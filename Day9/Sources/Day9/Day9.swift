struct Point: Hashable {
    let x: Int
    let y: Int
}

struct DepthMap {
    private let depthMap: [Point: Int]

    init(_ string: String) {
        let arrayMap = string.split(separator: "\n")
            .map { $0.compactMap { Int(String($0)) } }
        depthMap = Dictionary(uniqueKeysWithValues: arrayMap.enumerated().flatMap { (y, line) in
            line.enumerated().map { (x, value) in
                (Point(x: x, y: y), value)
            }
        })
    }

    private var minima: [Point: Int] {
        depthMap.filter { (key, value) in
            depthMap.neighbors(of: key).allSatisfy { $0 > value }
        }
    }

    var basins: Set<Set<Point>> {
        Set(minima.keys.map { depthMap.basin(around: $0) })
    }

    /// Part 1 answer
    var riskLevel: Int {
        minima.values
            .map { $0 + 1 }
            .reduce(0, +)
    }

    /// Part 2 answer
    var basinValue: Int {
        basins.map(\.count)
            .sorted()
            .suffix(3)
            .reduce(1, *)
    }
}

private extension Dictionary where Key == Point, Value == Int {
    private subscript(x: Int, y: Int) -> Value? {
        self[Point(x: x, y: y)]
    }

    private func adjacentCoordinates(of point: Point) -> Set<Point> {
        Set([
            Point(x: point.x + 1, y: point.y),
            Point(x: point.x - 1, y: point.y),
            Point(x: point.x, y: point.y + 1),
            Point(x: point.x, y: point.y - 1)
        ].filter(keys.contains))
    }

    /// The (up to) 4 neighbors to the left, right, top, and bottom
    func neighbors(of point: Point) -> [Value] {
        adjacentCoordinates(of: point).compactMap { self[$0] }
    }

    func basin(around point: Point, alreadyKnown: Set<Point> = []) -> Set<Point> {
        let neighbors = adjacentCoordinates(of: point)
            .filter { !alreadyKnown.contains($0) }
            .filter { self[$0] != 9 }

        var alreadyKnown = alreadyKnown.union([point])
        for neighbor in neighbors {
            alreadyKnown.formUnion(basin(around: neighbor, alreadyKnown: alreadyKnown))
        }
        return alreadyKnown
    }
}
