struct Point: Hashable {
    let x: Int
    let y: Int
}

struct OctopusField {
    var energyLevels: [Point: Int] = [:]
    var totalFlashes = 0

    var allOctopiJustFlashed = false

    init(_ string: String) {
        for (y, line) in string.split(separator: "\n").enumerated() {
            for (x, number) in line.compactMap({ Int(String($0)) }).enumerated() {
                energyLevels[Point(x: x, y: y)] = number
            }
        }
    }

    mutating func step() {
        var pointsThatJustFlashed: Set<Point> = []

        var pointsToIncrease = (0...9).flatMap { y in (0...9).map { x in Point(x: x, y: y) }}

        while !pointsToIncrease.isEmpty {
            var newPointsToIncrease: [Point] = []
            for point in pointsToIncrease {
                energyLevels[point, default: 0] += 1
                if energyLevels[point] == 10 {
                    pointsThatJustFlashed.insert(point)
                    newPointsToIncrease += neighbors(of: point)
                }
                if pointsThatJustFlashed.contains(point) {
                    energyLevels[point] = 0
                }
            }

            newPointsToIncrease.removeAll(where: pointsThatJustFlashed.contains)
            pointsToIncrease = newPointsToIncrease
        }

        if pointsThatJustFlashed.count == 100 {
            allOctopiJustFlashed = true
        }

        totalFlashes += pointsThatJustFlashed.count
    }

    /// The up to 8 surrounding neighbors of a point
    private func neighbors(of point: Point) -> Set<Point> {
        let (x, y) = (point.x, point.y)
        return Set([
            Point(x: x - 1, y: y - 1),
            Point(x: x,     y: y - 1),
            Point(x: x + 1, y: y - 1),
            Point(x: x - 1, y: y    ),
            Point(x: x + 1, y: y    ),
            Point(x: x - 1, y: y + 1),
            Point(x: x,     y: y + 1),
            Point(x: x + 1, y: y + 1)
        ]).filter(energyLevels.keys.contains)
    }
}

extension OctopusField: CustomStringConvertible {
    var description: String {
        var characters: [Character] = []
        for y in 0...9 {
            for x in 0...9 {
                characters += "\(energyLevels[Point(x: x, y: y)]!)"
            }
            characters += "\n"
        }
        return String(characters.dropLast())
    }
}
