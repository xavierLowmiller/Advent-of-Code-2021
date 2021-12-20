struct Point: Hashable {
    let x: Int
    let y: Int

    var neighbors: [Point] {
        [
            Point(x: x - 1, y: y - 1),
            Point(x: x    , y: y - 1),
            Point(x: x + 1, y: y - 1),
            Point(x: x - 1, y: y    ),
            Point(x: x    , y: y    ),
            Point(x: x + 1, y: y    ),
            Point(x: x - 1, y: y + 1),
            Point(x: x    , y: y + 1),
            Point(x: x + 1, y: y + 1)
        ]
    }
}

struct Image: CustomStringConvertible {
    var data: [Point: Bool]

    init<S: StringProtocol>(_ input: S) {
        data = Dictionary(uniqueKeysWithValues: input.split(separator: "\n").enumerated().flatMap { (y, line) in
            line.enumerated().map { (x, char) in
                (Point(x: x, y: y), char == "#")
            }
        })
    }

    var description: String {
        let minX = data.keys.map(\.x).min()!
        let maxX = data.keys.map(\.x).max()!
        let minY = data.keys.map(\.y).min()!
        let maxY = data.keys.map(\.y).max()!

        var result = ""
        for y in minY...maxY {
            for x in minX...maxX {
                result.append(data[Point(x: x, y: y), default: false] ? "#" : ".")
            }
            result.append("\n")
        }
        return result
    }

    /// Adds a 1-pixel-wide border to the image
    /// (so the enhancement can always work)
    private mutating func expand(_ value: Bool = false) {
        let minX = data.keys.map(\.x).min()! - 1
        let maxX = data.keys.map(\.x).max()! + 1
        let minY = data.keys.map(\.y).min()! - 1
        let maxY = data.keys.map(\.y).max()! + 1

        for y in minY...maxY {
            for x in minX...maxX {
                let point = Point(x: x, y: y)
                if !data.keys.contains(point) {
                    data[point] = value
                }
            }
        }
    }

    mutating func enhanceTwice(using algorithm: [Bool]) {
        expand(false)

        var newData: [Point: Bool] = [:]

        for point in data.keys {
            let neighbors = point.neighbors
            let lookupValue = numberValue(for: neighbors, default: false)
            newData[point] = algorithm[lookupValue]
        }

        data = newData

        expand(algorithm[0])

        for point in data.keys {
            let neighbors = point.neighbors
            let lookupValue = numberValue(for: neighbors, default: algorithm[0])
            newData[point] = algorithm[lookupValue]
        }

        data = newData
    }

    private func numberValue(for points: [Point], default: Bool) -> Int {
        Int(String(points.map { data[$0, default: `default`] ? "1" : "0" }), radix: 2)!
    }
}
