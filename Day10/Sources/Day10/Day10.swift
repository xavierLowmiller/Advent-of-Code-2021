struct SyntaxChecker<S: StringProtocol> {
    let lines: [S]

    /// The score needed for part 1
    var totalSyntaxErrorScore: Int {
        lines
            .compactMap(\.syntaxError)
            .map {
                switch $0 {
                case .invalidCharacter(")"):
                    return 3
                case .invalidCharacter("]"):
                    return 57
                case .invalidCharacter("}"):
                    return 1197
                case .invalidCharacter(">"):
                    return 25137
                case _:
                    return 0
                }
            }
            .reduce(0, +)
    }

    /// The score needed for part 2
    var completionScore: Int {
        let scores = lines
            .compactMap(\.syntaxError)
            .compactMap { (error: SyntaxError) -> String? in
                guard case .incomplete(let remaining) = error else { return nil }
                return remaining
            }
            .compactMap { remaining in
                remaining.reduce(0) { (total: Int, newValue: Character) in
                    let value: Int
                    switch newValue {
                    case ")":
                        value = 1
                    case "]":
                        value = 2
                    case "}":
                        value = 3
                    case ">":
                        value = 4
                    case _:
                        return total
                    }

                    return total * 5 + value
                }
            }
            .sorted()

        return scores[scores.count / 2]
    }
}
