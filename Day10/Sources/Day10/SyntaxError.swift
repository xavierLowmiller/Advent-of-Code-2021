enum SyntaxError {
    case invalidCharacter(Character)
    case incomplete(String)
    case unknownCharater
}

extension StringProtocol {

    var syntaxError: SyntaxError? {
        var stack: [Character] = []

        for c in self {
            switch c {
            case "(", "[", "{", "<":
                stack.append(c)
            case ")":
                if stack.popLast() != "(" {
                    return .invalidCharacter(c)
                }
            case "]":
                if stack.popLast() != "[" {
                    return .invalidCharacter(c)
                }
            case "}":
                if stack.popLast() != "{" {
                    return .invalidCharacter(c)
                }
            case ">":
                if stack.popLast() != "<" {
                    return .invalidCharacter(c)
                }
            case _:
                return .unknownCharater
            }
        }

        guard stack.isEmpty else {
            return .incomplete(String(stack.map { (c: Character) -> Character in
                switch c {
                case "(":
                    return ")"
                case "[":
                    return "]"
                case "{":
                    return "}"
                case "<":
                    return ">"
                case _:
                    fatalError()
                }
            }.reversed()))
        }

        return nil
    }
}
