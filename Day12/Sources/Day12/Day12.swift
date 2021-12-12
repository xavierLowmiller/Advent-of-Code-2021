struct Cave: Hashable {
    let name: Substring

    var isSmall: Bool {
        name.allSatisfy(\.isLowercase)
    }

    static let start = Cave(name: "start")
    static let end = Cave(name: "end")
}

struct CaveSystem {
    let paths: [Cave: Set<Cave>]

    init(_ input: String) {
        let pairs = input.split(separator: "\n").flatMap {[
            (Cave(name: $0.split(separator: "-")[0]), Cave(name: $0.split(separator: "-")[1])),
            (Cave(name: $0.split(separator: "-")[1]), Cave(name: $0.split(separator: "-")[0]))
        ]}

        paths = Dictionary(grouping: pairs, by: \.0)
            .mapValues { Set($0.map(\.1)).subtracting([.start]) }
    }

    func validPaths(
        currentNode: Cave = .start,
        pathSoFar: [Cave] = [],
        canVisitOneCaveTwice: Bool
    ) -> [[Cave]] {

        let pathSoFar = pathSoFar + [currentNode]

        guard currentNode != .end else { return [pathSoFar] }
        guard pathSoFar.isValid(for: canVisitOneCaveTwice) else { return [] }

        return paths[currentNode, default: []].flatMap {
            validPaths(
                currentNode: $0,
                pathSoFar: pathSoFar,
                canVisitOneCaveTwice: canVisitOneCaveTwice
            )
        }
    }
}

private extension Array where Element == Cave {
    func isValid(for canVisitOneCaveTwice: Bool) -> Bool {
        let smallCavesVisited = filter(\.isSmall)
        if canVisitOneCaveTwice {
            return smallCavesVisited.count - Set(smallCavesVisited).count <= 1
        } else {
            return smallCavesVisited.count == Set(smallCavesVisited).count
        }
    }
}
