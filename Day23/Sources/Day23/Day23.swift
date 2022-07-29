public enum Amphipod: CaseIterable, Hashable, CustomStringConvertible {
    case A, B, C, D

    var cost: Int {
        switch self {
        case .A: return 1
        case .B: return 10
        case .C: return 100
        case .D: return 1000
        }
    }

    var homeIndexLeft: Int {
        switch self {
        case .A: return 1
        case .B: return 2
        case .C: return 3
        case .D: return 4
        }
    }

    var homeIndexRight: Int {
        switch self {
        case .A: return 2
        case .B: return 3
        case .C: return 4
        case .D: return 5
        }
    }

    var homeCave: WritableKeyPath<AmphipodCave, Array<Amphipod?>> {
        switch self {
        case .A: return \.cave1
        case .B: return \.cave2
        case .C: return \.cave3
        case .D: return \.cave4
        }
    }

    public var description: String {
        switch self {
        case .A: return "A"
        case .B: return "B"
        case .C: return "C"
        case .D: return "D"
        }
    }
}

private extension StringProtocol {
    var amphipod: Amphipod? {
        switch self {
        case "A": return .A
        case "B": return .B
        case "C": return .C
        case "D": return .D
        default: return nil
        }
    }
}

public struct AmphipodCave: Hashable, CustomStringConvertible {

    private let caveDepth: Int

    var cave1: [Amphipod?]
    var cave2: [Amphipod?]
    var cave3: [Amphipod?]
    var cave4: [Amphipod?]

    var hallway = [Amphipod?](repeating: nil, count: 7)

    public enum Part {
        case part1
        case part2
    }

    public init(
        cave1: [Amphipod?],
        cave2: [Amphipod?],
        cave3: [Amphipod?],
        cave4: [Amphipod?],
        hallway: [Amphipod?] = [Amphipod?](repeating: nil, count: 7),
        part: AmphipodCave.Part = .part1
    ) {
        self.cave1 = cave1
        self.cave2 = cave2
        self.cave3 = cave3
        self.cave4 = cave4
        self.hallway = hallway
        caveDepth = part == .part1 ? 2 : 4
    }

    public var description: String {
        if caveDepth == 4 {
        return """
            #############
            #\(hallway[0].s)\(hallway[1].s).\(hallway[2].s).\(hallway[3].s).\(hallway[4].s).\(hallway[5].s)\(hallway[6].s)#
            ###\(cave1[3].s)#\(cave2[3].s)#\(cave3[3].s)#\(cave4[3].s)###
              #\(cave1[2].s)#\(cave2[2].s)#\(cave3[2].s)#\(cave4[2].s)#
              #\(cave1[1].s)#\(cave2[1].s)#\(cave3[1].s)#\(cave4[1].s)#
              #\(cave1[0].s)#\(cave2[0].s)#\(cave3[0].s)#\(cave4[0].s)#
              #########
            """
        } else {
            return """
            #############
            #\(hallway[0].s)\(hallway[1].s).\(hallway[2].s).\(hallway[3].s).\(hallway[4].s).\(hallway[5].s)\(hallway[6].s)#
            ###\(cave1[1].s)#\(cave2[1].s)#\(cave3[1].s)#\(cave4[1].s)###
              #\(cave1[0].s)#\(cave2[0].s)#\(cave3[0].s)#\(cave4[0].s)#
              #########
            """
        }
    }

    public static func goal(for part: Part) -> AmphipodCave {
        switch part {
        case .part1:
            return AmphipodCave(
                cave1: [.A, .A],
                cave2: [.B, .B],
                cave3: [.C, .C],
                cave4: [.D, .D],
                part: part
            )
        case .part2:
            return AmphipodCave(
                cave1: [.A, .A, .A, .A],
                cave2: [.B, .B, .B, .B],
                cave3: [.C, .C, .C, .C],
                cave4: [.D, .D, .D, .D],
                part: part
            )
        }
    }
}

extension AmphipodCave {
    public init<S: StringProtocol>(_ input: S, part: Part = .part1) {
        let caveLines = input.split(separator: "\n").dropFirst(2).dropLast()
        assert(caveLines.count == 2)

        cave1 = []
        cave2 = []
        cave3 = []
        cave4 = []

        var line1 = caveLines.first!.split(separator: "#", omittingEmptySubsequences: true)
        var line2 = caveLines.last!.split(separator: "#", omittingEmptySubsequences: true).dropFirst()
        assert(line1.count == 4)
        assert(line2.count == 4)

        cave1.append(line2.removeFirst().amphipod)
        if part == .part2 { cave1.append(.D) }
        if part == .part2 { cave1.append(.D) }
        cave1.append(line1.removeFirst().amphipod)

        cave2.append(line2.removeFirst().amphipod)
        if part == .part2 { cave2.append(.B) }
        if part == .part2 { cave2.append(.C) }
        cave2.append(line1.removeFirst().amphipod)

        cave3.append(line2.removeFirst().amphipod)
        if part == .part2 { cave3.append(.A) }
        if part == .part2 { cave3.append(.B) }
        cave3.append(line1.removeFirst().amphipod)

        cave4.append(line2.removeFirst().amphipod)
        if part == .part2 { cave4.append(.C) }
        if part == .part2 { cave4.append(.A) }
        cave4.append(line1.removeFirst().amphipod)

        caveDepth = part == .part1 ? 2 : 4
    }
}

extension AmphipodCave {
    public func costOfSorting(in part: Part) -> Int {
        guard let (_, cost) = aStar(
            start: self,
            goal: .goal(for: part),
            heuristic: { _ in 0 },
            neighbors: \.neighbors
        )
        else { fatalError("No solution was found!") }

        return cost
    }

    private var neighborsThatMoveAnAmphipodToItsHomeCave: Set<Neighbor<AmphipodCave>> {
        var neighbors: Set<Neighbor<AmphipodCave>> = []
        for (offset, amphipod) in hallway.enumerated() {
            guard let amphipod = amphipod,
                  hallway.wayHomeIsFree(for: offset),
                  self[keyPath: amphipod.homeCave].allSatisfy({ $0 == amphipod || $0 == nil }),
                  let insertionIndex = self[keyPath: amphipod.homeCave].firstIndex(where: { $0 == nil })
            else { continue }

            var copy = self
            copy.hallway[offset] = nil
            copy[keyPath: amphipod.homeCave][insertionIndex] = amphipod

            let steps = steps(for: offset, from: amphipod) + caveDepth - (insertionIndex + 1)
            neighbors.insert(Neighbor(node: copy, cost: steps * amphipod.cost))
        }
        return neighbors
    }

    private var neighborsThatMoveAnAmphipodOutOfItsCave: Set<Neighbor<AmphipodCave>> {
        var neighbors: Set<Neighbor<AmphipodCave>> = []

        for pod in Amphipod.allCases {
            let cave = self[keyPath: pod.homeCave]
            guard cave.contains(where: { $0 != pod && $0 != nil }) else { continue }

            let minIndex = hallway[...pod.homeIndexLeft].lastIndex(where: { $0 != nil }) ?? -1
            let maxIndex = hallway[pod.homeIndexRight...].firstIndex(where: { $0 != nil }) ?? 7
            guard minIndex + 1 <= maxIndex - 1, let removalIndex = cave.lastIndex(where: { $0 != nil })
            else { continue }


            for index in (minIndex + 1)...(maxIndex - 1) {
                var copy = self

                let podThatMoves = cave[removalIndex]!
                copy[keyPath: pod.homeCave][removalIndex] = nil
                copy.hallway[index] = podThatMoves

                let steps = steps(for: index, from: pod) + caveDepth - (removalIndex + 1)
                neighbors.insert(Neighbor(node: copy, cost: steps * podThatMoves.cost))
            }
        }

        return neighbors
    }

    public var neighbors: Set<Neighbor<AmphipodCave>> {
        let n1 = neighborsThatMoveAnAmphipodToItsHomeCave
        if n1.isEmpty {
            return neighborsThatMoveAnAmphipodOutOfItsCave
        } else {
            return n1
        }
    }
}

extension Array where Element == Amphipod? {
    public func wayHomeIsFree(for offset: Int) -> Bool {
        switch self[offset] {
        case nil:
            return false
        case let amphipod? where offset < amphipod.homeIndexLeft:
            return self[(offset + 1)...amphipod.homeIndexLeft].allSatisfy { $0 == nil }
        case let amphipod? where offset > amphipod.homeIndexRight:
            return self[amphipod.homeIndexRight...(offset - 1)].allSatisfy { $0 == nil }
        case _:
            return true
        }
    }
}

private func steps(for index: Int, from cave: Amphipod) -> Int {
    switch (cave, index) {
    case (.A, 0): return 3
    case (.A, 1): return 2
    case (.A, 2): return 2
    case (.A, 3): return 4
    case (.A, 4): return 6
    case (.A, 5): return 8
    case (.A, 6): return 9

    case (.B, 0): return 5
    case (.B, 1): return 4
    case (.B, 2): return 2
    case (.B, 3): return 2
    case (.B, 4): return 4
    case (.B, 5): return 6
    case (.B, 6): return 7

    case (.C, 0): return 7
    case (.C, 1): return 6
    case (.C, 2): return 4
    case (.C, 3): return 2
    case (.C, 4): return 2
    case (.C, 5): return 4
    case (.C, 6): return 5

    case (.D, 0): return 9
    case (.D, 1): return 8
    case (.D, 2): return 6
    case (.D, 3): return 4
    case (.D, 4): return 2
    case (.D, 5): return 2
    case (.D, 6): return 3

    default: fatalError()
    }
}

extension Optional<Amphipod> {
    var s: String {
        switch self {
        case .some(let pod):
            return pod.description
        case .none:
            return "."
        }
    }
}
