struct TwoCharacters: Hashable {
    let c1: Character
    let c2: Character
}

struct Polymerization {
    var state: [TwoCharacters: Int]
    private let replacementRules: [TwoCharacters: Character]
    private let firstCharacter: Character

    init(initialState: String, replacementRules: String) {
        self.state = Dictionary(initialState)
        self.replacementRules = Dictionary(replacementRules)
        self.firstCharacter = initialState.first!
    }

    mutating func grow() {
        var newState: [TwoCharacters: Int] = [:]
        for (pair, count) in state {
            let insertedCharacter = replacementRules[pair]!
            newState[TwoCharacters(c1: pair.c1, c2: insertedCharacter), default: 0] += count
            newState[TwoCharacters(c1: insertedCharacter, c2: pair.c2), default: 0] += count
        }
        state = newState
    }

    /// Difference between the most common and least common element
    var elementDiff: Int {
        var counts = state.reduce(into: [:]) { $0[$1.key.c2, default: 0] += $1.value }
        counts[firstCharacter, default: 0] += 1
        return counts.values.max()! - counts.values.min()!
    }
}

private extension Dictionary where Key == TwoCharacters, Value == Int {
    init(_ input: String) {
        self = zip(input, input.dropFirst()).map(TwoCharacters.init)
            .reduce(into: [:]) { $0[$1, default: 0] += 1 }
    }
}

private extension Dictionary where Key == TwoCharacters, Value == Character {
    init(_ input: String) {
        self.init(uniqueKeysWithValues: input.split(separator: "\n").map { line in
            let c1 = line.first!
            let c2 = line.dropFirst().first!

            return (TwoCharacters(c1: c1, c2: c2), line.last!)
        })
    }
}
