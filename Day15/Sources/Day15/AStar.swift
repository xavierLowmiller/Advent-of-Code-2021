/**
 The A* search algorithm.
 Finds the shortest/cheapest path from `start` to `goal`

 - Parameters:
     - start: The initial position
     - end: The desired goal position
     - cost: The cost it takes to to traverse from `n1` to `n2`
     - heuristic: A heuristic value for the given point.
        Lower values indicate a more suitable node.
     - neighbors: The set of nodes a given node can traverse to.

 - Returns: The shortest/cheapest path from `start` to `goal`,
    or nil if no such path exists.
 */
func aStar<Node: Hashable, S: Sequence>(
    start: Node,
    goal: Node,
    cost: (_ n1: Node, _ n2: Node) -> Int = { _, _ in 1 },
    heuristic: (Node) -> Int,
    neighbors: (Node) -> S
) -> [Node]? where S.Element == Node {

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
            return reconstructPath(cameFrom: cameFrom, current: current)
        }

        openSet.remove(current)
        for neighbor in neighbors(current) {
            // d(current,neighbor) is the weight of the edge from current to neighbor
            // tentative_gScore is the distance from start to the neighbor through current
            let tentativeGScore = gScore[current]! + cost(current, neighbor)
            let existing = gScore[neighbor, default: .max]
            if tentativeGScore < existing {
                // This path to neighbor is better than any previous one. Record it!
                cameFrom[neighbor] = current
                gScore[neighbor] = tentativeGScore
                fScore[neighbor] = tentativeGScore + heuristic(neighbor)
                openSet.insert(neighbor)
            }
        }
    }

    // Open set is empty but goal was never reached
    return nil
}

private func reconstructPath<Node: Hashable>(cameFrom: [Node: Node], current: Node) -> [Node] {
    var current = current
    var totalPath = [current]
    while let value = cameFrom[current] {
        current = value
        totalPath.append(value)
    }
    return totalPath.reversed()
}
