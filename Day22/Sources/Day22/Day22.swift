struct Cuboid: Equatable {
    var xRange: ClosedRange<Int>
    var yRange: ClosedRange<Int>
    var zRange: ClosedRange<Int>

    func intersection(with other: Cuboid) -> Cuboid? {
        guard xRange.overlaps(other.xRange),
              yRange.overlaps(other.yRange),
              zRange.overlaps(other.zRange)
        else { return nil }

        let xRange = xRange.clamped(to: other.xRange)
        let yRange = yRange.clamped(to: other.yRange)
        let zRange = zRange.clamped(to: other.zRange)

        return Cuboid(xRange: xRange, yRange: yRange, zRange: zRange)
    }

    var volume: Int {
        xRange.count * yRange.count * zRange.count
    }
}

struct Instruction {
    let turnsOn: Bool
    let xRange: ClosedRange<Int>
    let yRange: ClosedRange<Int>
    let zRange: ClosedRange<Int>

    init<S: StringProtocol>(_ input: S) {
        turnsOn = input.split(separator: " ")[0] == "on"
        let ranges = input.split(separator: " ")[1].split(separator: ",")
        let xRange = ranges[0].split(separator: "=")[1].split(separator: ".", omittingEmptySubsequences: true)
        let yRange = ranges[1].split(separator: "=")[1].split(separator: ".", omittingEmptySubsequences: true)
        let zRange = ranges[2].split(separator: "=")[1].split(separator: ".", omittingEmptySubsequences: true)
        self.xRange = Int(xRange[0])!...Int(xRange[1])!
        self.yRange = Int(yRange[0])!...Int(yRange[1])!
        self.zRange = Int(zRange[0])!...Int(zRange[1])!
    }
}

struct Reactor {
    let cuboids: [(Cuboid, isOn: Bool)]

    init<S: StringProtocol>(_ input: S, onlySmallValues: Bool) {
        var instructions = input.split(separator: "\n").map(Instruction.init)

        if onlySmallValues {
            instructions = instructions.filter {
                $0.xRange.lowerBound >= -50 && $0.xRange.upperBound <= 50
                && $0.yRange.lowerBound >= -50 && $0.yRange.upperBound <= 50
                && $0.zRange.lowerBound >= -50 && $0.zRange.upperBound <= 50
            }
        }

        cuboids = instructions.map {
            (Cuboid(xRange: $0.xRange, yRange: $0.yRange, zRange: $0.zRange), $0.turnsOn)
        }
    }

    var numberOfPointsThatAreOn: Int {
        cuboids.enumerated().compactMap { (index, cuboid) in
            guard cuboid.isOn else { return nil }
            let cuboid = cuboid.0

            let intersections = cuboids.dropFirst(index + 1)
                .map(\.0)
                .compactMap(cuboid.intersection)

            return cuboid.volume - intersections.combinedVolume
        }.reduce(0, +)
    }
}

extension Collection where Element == Cuboid {
    var combinedVolume: Int {
        guard let head = first else { return 0 }
        let tail = dropFirst()

        let intersections = tail.compactMap(head.intersection)

        return head.volume - intersections.combinedVolume + tail.combinedVolume
    }
}
