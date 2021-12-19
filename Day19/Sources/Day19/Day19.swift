struct Point: Hashable {
    let x: Int
    let y: Int
    let z: Int

    static func - (lhs: Point, rhs: Point) -> Point {
        Point(
            x: lhs.x - rhs.x,
            y: lhs.y - rhs.y,
            z: lhs.z - rhs.z
        )
    }

    static func + (lhs: Point, rhs: Point) -> Point {
        Point(
            x: rhs.x + lhs.x,
            y: rhs.y + lhs.y,
            z: rhs.z + lhs.z
        )
    }

    var manhattanDistance: Int {
        abs(x) + abs(y) + abs(z)
    }

    var rotatedByX: Point {
        Point(x: x, y: z, z: -y)
    }

    var rotatedByY: Point {
        Point(x: z, y: y, z: -x)
    }

    var rotatedByZ: Point {
        Point(x: -y, y: x, z: z)
    }
}

struct Scanner: Hashable {
    let points: Set<Point>
}

extension Scanner {
    init<S: StringProtocol>(_ input: S) {
        points = Set(input.split(separator: "\n").dropFirst().map {
            let coords = $0.split(separator: ",").compactMap { Int($0) }
            return Point(x: coords[0], y: coords[1], z: coords[2])
        })
    }

    var allRotations: [Scanner] {
        [
            // I
            points.map { $0 },
            // X
            points.map(\.rotatedByX),
            // Y
            points.map(\.rotatedByY),
            // Z
            points.map(\.rotatedByZ),
            // XX
            points.map(\.rotatedByX.rotatedByX),
            // XY
            points.map(\.rotatedByX.rotatedByY),
            // XZ
            points.map(\.rotatedByX.rotatedByZ),
            // YX
            points.map(\.rotatedByY.rotatedByX),
            // YY
            points.map(\.rotatedByY.rotatedByY),
            // ZY
            points.map(\.rotatedByZ.rotatedByY),
            // ZZ
            points.map(\.rotatedByZ.rotatedByZ),
            // XXX
            points.map(\.rotatedByX.rotatedByX.rotatedByX),
            // XXY
            points.map(\.rotatedByX.rotatedByX.rotatedByY),
            // XXZ
            points.map(\.rotatedByX.rotatedByX.rotatedByZ),
            // XYX
            points.map(\.rotatedByX.rotatedByY.rotatedByX),
            // XYY
            points.map(\.rotatedByX.rotatedByY.rotatedByY),
            // XZZ
            points.map(\.rotatedByX.rotatedByZ.rotatedByZ),
            // YXX
            points.map(\.rotatedByY.rotatedByX.rotatedByX),
            // YYY
            points.map(\.rotatedByY.rotatedByY.rotatedByY),
            // ZZZ
            points.map(\.rotatedByZ.rotatedByZ.rotatedByZ),
            // XXXY
            points.map(\.rotatedByX.rotatedByX.rotatedByX.rotatedByY),
            // XXYX
            points.map(\.rotatedByX.rotatedByX.rotatedByY.rotatedByX),
            // XYXX
            points.map(\.rotatedByX.rotatedByY.rotatedByX.rotatedByX),
            // XYYY
            points.map(\.rotatedByX.rotatedByY.rotatedByY.rotatedByY),
        ].map { Scanner(points: Set($0)) }
    }
}

struct Solution {
    var points: Set<Point>
    var scannerPositions: Set<Point>

    var amountOfPoints: Int {
        points.count
    }

    var maxManattanDistance: Int {
        var allManhattanDistances: [Int] = []

        for position1 in scannerPositions {
            for position2 in scannerPositions {
                allManhattanDistances.append((position1 - position2).manhattanDistance)
            }
        }

        return allManhattanDistances.max()!
    }

    init(scanners a: Set<Scanner>) {
        var scanners = a
        points = scanners.removeFirst().points
        scannerPositions = [Point(x: 0, y: 0, z: 0)]

        while !scanners.isEmpty {
        outerLoop:
            for point1 in points {
                let existingDiffs = Set(points.map { $0 - point1 })

                for scanner in scanners {
                    for rotation in scanner.allRotations {
                        for point2 in rotation.points {

                            let rotationDiffs = Set(rotation.points.map { $0 - point2 })

                            if existingDiffs.intersection(rotationDiffs).count >= 12 {
                                scanners.remove(scanner)
                                let fromPoint2ToPoint1 = point1 - point2
                                for point in rotation.points {
                                    points.insert(point + fromPoint2ToPoint1)
                                }

                                scannerPositions.insert(fromPoint2ToPoint1)

                                print(scanners.count)

                                break outerLoop
                            }
                        }
                    }
                }
            }
        }
    }
}
