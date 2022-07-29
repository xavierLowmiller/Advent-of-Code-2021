/**
 The A* search algorithm.
 Finds the shortest/cheapest path from `start` to `goal`

 - Parameters:
     - start: The initial position
     - end: The desired goal position
     - heuristic: A heuristic value for the given point.
                  Lower values indicate a more suitable node.
     - neighbors: The set of nodes a given node can traverse to,
                  and the cost of that traversal

 - Returns: The shortest/cheapest path from `start` to `goal`,
    or nil if no such path exists.
 */
func aStar<Node: Hashable & CustomStringConvertible, S: Sequence>(
    start: Node,
    goal: Node,
    heuristic: (Node) -> Int,
    neighbors: (Node) -> S
) -> ([Node], Int)? where S.Element == Neighbor<Node> {

    // The set of discovered nodes that may need to be (re-)expanded.
    // Initially, only the start node is known.
    // This is usually implemented as a min-heap or priority queue rather than a hash-set.
    var openSet: Set<Node> = [start]

    // For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start
    // to n currently known.
    var cameFrom: [Node: Node] = [:]

    // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
    var gScore: [Node: Int] = [start: 0]

    // For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
    // how short a path from start to finish can be if it goes through n.
    var fScore: [Node: Int] = [start: heuristic(start)]

    while !openSet.isEmpty {
        // This operation can occur in O(1) time if openSet is a min-heap or a priority queue
        let current = openSet.min { fScore[$0]! < fScore[$1]! }!
        if current == goal {
            return (reconstructPath(cameFrom: cameFrom, current: current), gScore[goal]!)
        }

        openSet.remove(current)
        for neighbor in neighbors(current) {
            let node = neighbor.node
            // d(current,neighbor) is the weight of the edge from current to neighbor
            // tentative_gScore is the distance from start to the neighbor through current
            let tentativeGScore = gScore[current]! + neighbor.cost
            let existing = gScore[node, default: .max]
            if tentativeGScore < existing {
                // This path to neighbor is better than any previous one. Record it!
                cameFrom[node] = current
                gScore[node] = tentativeGScore
                fScore[node] = tentativeGScore + heuristic(node)
                openSet.insert(node)
            }
        }
    }

    // Open set is empty but goal was never reached
    return nil
}

private func reconstructPath<Node: Hashable & CustomStringConvertible>(cameFrom: [Node: Node], current: Node) -> [Node] {
    var current = current
    var totalPath = [current]
    while let value = cameFrom[current] {
        current = value
        totalPath.append(value)
    }
    print(totalPath.reversed().map(\.description).joined(separator: "\n\n"))
    return totalPath.reversed()
}

public struct Neighbor<Node: Hashable & CustomStringConvertible>: Hashable, CustomStringConvertible {
    public init(node: Node, cost: Int) {
        self.node = node
        self.cost = cost
    }

    var node: Node
    var cost: Int

    public var description: String {
        return "\(node.description) \(cost)"
    }
}
