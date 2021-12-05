struct Point: Hashable {
    let x: Int
    let y: Int
}

extension Point {
    init(_ string: String) {
        x = Int(string.split(separator: ",")[0])!
        y = Int(string.split(separator: ",")[1])!
    }
}

struct LinePair {
    let point1: Point
    let point2: Point

    func allPoints(considerDiagonalLines: Bool) -> [Point] {
        if point1.x == point2.x {
            return (min(point1.y, point2.y)...max(point1.y, point2.y)).map { y in
                Point(x: point1.x, y: y)
            }
        } else if point1.y == point2.y {
            return (min(point1.x, point2.x)...max(point1.x, point2.x)).map { x in
                Point(x: x, y: point1.y)
            }
        } else if considerDiagonalLines {
            let xValues = point1.x < point2.x ? AnySequence(point1.x...point2.x) : AnySequence((point2.x...point1.x).reversed())
            let yValues = point1.y < point2.y ? AnySequence(point1.y...point2.y) : AnySequence((point2.y...point1.y).reversed())

            return zip(xValues, yValues).map { (x, y) in
                Point(x: x, y: y)
            }
        } else {
            // Not horizontal or vertical, skip this one
            return []
        }
    }
}

import Foundation

struct HydrothermalVentMap {
    var dangerZones: [Point: Int] = [:]
    let considerDiagonalLines: Bool

    init(dangerZones: [Point: Int] = [:], considerDiagonalLines: Bool) {
        self.dangerZones = dangerZones
        self.considerDiagonalLines = considerDiagonalLines
    }

    mutating func addLine(_ line: String) {
        let separated = line.components(separatedBy: " -> ")
        let point1 = Point(separated[0])
        let point2 = Point(separated[1])
        let linePair = LinePair(point1: point1, point2: point2)

        for point in linePair.allPoints(considerDiagonalLines: considerDiagonalLines) {
            dangerZones[point, default: 0] += 1
        }
    }

    var amountOfMostDangerousPoints: Int {
        dangerZones.filter { $0.value >= 2 }.count
    }
}
