struct Point: Hashable {
    let x: Int
    let y: Int

    func distance(to other: Point) -> Int {
        abs(other.x - x) + abs(other.y - y)
    }
}

struct CaveSystem {
    let cave: [Point: Int]

    init(_ input: String, fullMap: Bool = false) {
        if fullMap {
            let allInput = input.repeatedFiveTimes
            cave = Dictionary(uniqueKeysWithValues: allInput.split(separator: "\n").enumerated().flatMap { y, line in
                line.repeatedFiveTimes.enumerated().map { x, char in
                    (Point(x: x, y: y), char.wholeNumberValue!)
                }
            })
        } else {
            cave = Dictionary(uniqueKeysWithValues: input.split(separator: "\n").enumerated().flatMap { y, line in
                line.enumerated().map { x, char in
                    (Point(x: x, y: y), char.wholeNumberValue!)
                }
            })
        }
    }

    var lowestTotalRiskPath: Int {
        let start = Point(x: 0, y: 0)
        let end = Point(x: cave.keys.map(\.x).max()!, y: cave.keys.map(\.y).max()!)

        return aStar(
            start: start,
            goal: end,
            cost: { cave[$1]! }, heuristic: { $0.distance(to: end) },
            neighbors: { neighbors(of: $0) }
        )!.reduce(0) { $0 + cave[$1]! } - cave[start]!
    }

    private func neighbors(of point: Point) -> [Point] {
        [
            Point(x: point.x, y: point.y - 1),
            Point(x: point.x, y: point.y + 1),
            Point(x: point.x - 1, y: point.y),
            Point(x: point.x + 1, y: point.y),
        ].filter(cave.keys.contains)
    }
}

private extension String {
    var repeatedFiveTimes: String {
        [
            self.split(separator: "\n").map { $0.increased(by: 0) }.joined(separator: "\n"),
            self.split(separator: "\n").map { $0.increased(by: 1) }.joined(separator: "\n"),
            self.split(separator: "\n").map { $0.increased(by: 2) }.joined(separator: "\n"),
            self.split(separator: "\n").map { $0.increased(by: 3) }.joined(separator: "\n"),
            self.split(separator: "\n").map { $0.increased(by: 4) }.joined(separator: "\n")
        ].joined(separator: "\n")
    }
}

private extension Substring {
    var repeatedFiveTimes: String {
        [
            self.increased(by: 0),
            self.increased(by: 1),
            self.increased(by: 2),
            self.increased(by: 3),
            self.increased(by: 4)
        ].joined()
    }

    func increased(by number: Int) -> String {
        map { String($0.wholeNumberValue! + number > 9 ? $0.wholeNumberValue! + number - 9 : $0.wholeNumberValue! + number) }.joined()
    }
}
