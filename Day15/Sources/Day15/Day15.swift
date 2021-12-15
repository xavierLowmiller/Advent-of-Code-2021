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

        return aStar(start: start, goal: end) { $0.distance(to: end) }.reduce(0) { $0 + cave[$1]! } - cave[start]!
    }

    func reconstructPath(cameFrom: [Point: Point], current: Point) -> [Point] {
        var current = current
        var totalPath = [current]
        while let value = cameFrom[current] {
            current = value
            totalPath.append(value)
        }
        return totalPath.reversed()
    }

    // A* finds a path from start to goal.
    // h is the heuristic function. h(n) estimates the cost to reach goal from node n.
    func aStar(start: Point, goal: Point, h: (Point) -> Int) -> [Point] {

        // The set of discovered nodes that may need to be (re-)expanded.
        // Initially, only the start node is known.
        // This is usually implemented as a min-heap or priority queue rather than a hash-set.
        var openSet: Set<Point> = [start]

        // For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start
        // to n currently known.
        var cameFrom: [Point: Point] = [:]

        // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
        var gScore: [Point: Int] = [start: 0]

        // For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
        // how short a path from start to finish can be if it goes through n.
        var fScore: [Point: Int] = [start: h(start)]

        while !openSet.isEmpty {
            // This operation can occur in O(1) time if openSet is a min-heap or a priority queue
            let current = openSet.min { fScore[$0]! < fScore[$1]! }!
            if current == goal {
                return reconstructPath(cameFrom: cameFrom, current: current)
            }

            openSet.remove(current)
            for neighbor in neighbors(of: current) {
                // d(current,neighbor) is the weight of the edge from current to neighbor
                // tentative_gScore is the distance from start to the neighbor through current
                let tentativeGScore = gScore[current]! + cave[neighbor]!
                let existing = gScore[neighbor, default: .max]
                if tentativeGScore < existing {
                    // This path to neighbor is better than any previous one. Record it!
                    cameFrom[neighbor] = current
                    gScore[neighbor] = tentativeGScore
                    fScore[neighbor] = tentativeGScore + h(neighbor)
                    if !openSet.contains(neighbor) {
                        openSet.insert(neighbor)
                    }
                }
            }
        }

        // Open set is empty but goal was never reached
        fatalError()
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
