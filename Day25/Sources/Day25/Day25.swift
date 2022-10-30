struct Point: Hashable {
    var x: Int
    var y: Int
}

struct Seafloor: CustomStringConvertible, Equatable {
    var eastBound: Set<Point> = []
    var southBound: Set<Point> = []

    private var maxX: Int
    private var maxY: Int

    public init(_ string: String) {
        let lines = string.split(separator: "\n")
        var x = 0
        var y = 0
        maxX = 0
        for line in lines {
            for char in line {
                switch char {
                case ">":
                    eastBound.insert(Point(x: x, y: y))
                case "v":
                    southBound.insert(Point(x: x, y: y))
                default:
                    break
                }
                x += 1
            }
            maxX = x - 1
            x = 0
            y += 1
        }
        maxY = y - 1
        sanityCheck()
    }

    mutating func step() {
        var newEastBound: Set<Point> = []
        var newSouthBound: Set<Point> = []

        for point in eastBound {
            let newPoint = Point(x: (point.x + 1) % (maxX + 1), y: point.y)
            if eastBound.contains(newPoint) || southBound.contains(newPoint) {
                newEastBound.insert(point)
            } else {
                newEastBound.insert(newPoint)
            }
        }
        eastBound = newEastBound
        sanityCheck()

        for point in southBound {
            let newPoint = Point(x: point.x, y: (point.y + 1) % (maxY + 1))
            if eastBound.contains(newPoint) || southBound.contains(newPoint) {
                newSouthBound.insert(point)
            } else {
                newSouthBound.insert(newPoint)
            }
        }

        southBound = newSouthBound
        sanityCheck()
    }

    /// Call `step` until there is no more movement
    /// - Returns: the number of steps it took to cease all movement
    mutating func stepUntilStuck() -> Int {

        var oldEastBound: Set<Point> = []
        var oldSouthBound: Set<Point> = []
        var steps = 0
        repeat {
            oldEastBound = eastBound
            oldSouthBound = southBound
            step()
            steps += 1
        } while oldEastBound != eastBound || oldSouthBound != southBound

        return steps
    }

    private func sanityCheck() {
        assert(eastBound.map(\.x).max() ?? 0 <= maxX)
        assert(eastBound.map(\.y).max() ?? 0 <= maxY)
        assert(southBound.map(\.x).max() ?? 0 <= maxX)
        assert(southBound.map(\.y).max() ?? 0 <= maxY)
        assert(eastBound.intersection(southBound).isEmpty)
    }

    var description: String {
        var description = ""
        for y in 0...maxY {
            for x in 0...maxX {
                if eastBound.contains(Point(x: x, y: y)) {
                    description += ">"
                } else if southBound.contains(Point(x: x, y: y)) {
                    description += "v"
                } else {
                    description += "."
                }
            }
            description += "\n"
        }

        description.removeLast()

        return description
    }
}
