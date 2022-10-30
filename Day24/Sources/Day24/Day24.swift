enum Instruction: Equatable, CustomStringConvertible {
    enum Register: Equatable {
        case w, x, y, z

        init<S: StringProtocol>(_ input: S) {
            switch input {
            case "w": self = .w
            case "x": self = .x
            case "y": self = .y
            case "z": self = .z
            default: fatalError()
            }
        }
    }

    enum Argument: Equatable {
        case literal(Int)
        case register(Register)

        init<S: StringProtocol>(_ input: S) {
            if let value = Int(input) {
                self = .literal(value)
            } else {
                self = .register(.init(input))
            }
        }
    }

    case inp(Register)
    case add(Register, Argument)
    case mul(Register, Argument)
    case div(Register, Argument)
    case mod(Register, Argument)
    case eql(Register, Argument)

    init<S: StringProtocol>(_ command: S) {
        let segments = command.split(separator: " ")

        switch segments[0] {
        case "inp":
            self = .inp(Register(segments[1]))
        case "add":
            self = .add(Register(segments[1]), Argument(segments[2]))
        case "mul":
            self = .mul(Register(segments[1]), Argument(segments[2]))
        case "div":
            self = .div(Register(segments[1]), Argument(segments[2]))
        case "mod":
            self = .mod(Register(segments[1]), Argument(segments[2]))
        case "eql":
            self = .eql(Register(segments[1]), Argument(segments[2]))
        default:
            fatalError()
        }
    }

    var description: String {
        switch self {
        case .inp(let register):
            return "inp \(register)"
        case .add(let register, .literal(let argument)):
            return "add \(register) \(argument)"
        case .mul(let register, .literal(let argument)):
            return "mul \(register) \(argument)"
        case .div(let register, .literal(let argument)):
            return "div \(register) \(argument)"
        case .mod(let register, .literal(let argument)):
            return "mod \(register) \(argument)"
        case .eql(let register, .literal(let argument)):
            return "eql \(register) \(argument)"
        case .add(let register, .register(let argument)):
            return "add \(register) \(argument)"
        case .mul(let register, .register(let argument)):
            return "mul \(register) \(argument)"
        case .div(let register, .register(let argument)):
            return "div \(register) \(argument)"
        case .mod(let register, .register(let argument)):
            return "mod \(register) \(argument)"
        case .eql(let register, .register(let argument)):
            return "eql \(register) \(argument)"
        }
    }
}

public struct ALU {
    public var w = 0
    public var x = 0
    public var y = 0
    public var z = 0

    public init() {}

    static func parseProgram<S: StringProtocol>(_ program: S) -> [Instruction] {
        program.split(separator: "\n").map(Instruction.init)
    }

    public mutating func run<S: StringProtocol>(_ program: S, input: inout Int) {
        let instructions = Self.parseProgram(program)
        run(instructions, input: &input)
    }

    mutating func run<Instructions: Sequence>(_ instructions: Instructions, input: inout Int) where Instructions.Element == Instruction {

        let parseValue: (_ input: inout Int) -> Int = { input in
            let string = "\(input)"
            let r = Int(String(string.first!))!
            input = Int(string.dropFirst()) ?? 0
            return r
        }

        for instruction in instructions {

            switch instruction {
            case .inp(.w): w = parseValue(&input)
            case .inp(.x): x = parseValue(&input)
            case .inp(.y): y = parseValue(&input)
            case .inp(.z): z = parseValue(&input)


            case .add(.w, .register(.w)): w += w
            case .add(.w, .register(.x)): w += x
            case .add(.w, .register(.y)): w += y
            case .add(.w, .register(.z)): w += z
            case .add(.w, .literal(let value)): w += value

            case .add(.x, .register(.w)): x += w
            case .add(.x, .register(.x)): x += x
            case .add(.x, .register(.y)): x += y
            case .add(.x, .register(.z)): x += z
            case .add(.x, .literal(let value)): x += value

            case .add(.y, .register(.w)): y += w
            case .add(.y, .register(.x)): y += x
            case .add(.y, .register(.y)): y += y
            case .add(.y, .register(.z)): y += z
            case .add(.y, .literal(let value)): y += value

            case .add(.z, .register(.w)): z += w
            case .add(.z, .register(.x)): z += x
            case .add(.z, .register(.y)): z += y
            case .add(.z, .register(.z)): z += z
            case .add(.z, .literal(let value)): z += value


            case .mul(.w, .register(.w)): w *= w
            case .mul(.w, .register(.x)): w *= x
            case .mul(.w, .register(.y)): w *= y
            case .mul(.w, .register(.z)): w *= z
            case .mul(.w, .literal(let value)): w *= value

            case .mul(.x, .register(.w)): x *= w
            case .mul(.x, .register(.x)): x *= x
            case .mul(.x, .register(.y)): x *= y
            case .mul(.x, .register(.z)): x *= z
            case .mul(.x, .literal(let value)): x *= value

            case .mul(.y, .register(.w)): y *= w
            case .mul(.y, .register(.x)): y *= x
            case .mul(.y, .register(.y)): y *= y
            case .mul(.y, .register(.z)): y *= z
            case .mul(.y, .literal(let value)): y *= value

            case .mul(.z, .register(.w)): z *= w
            case .mul(.z, .register(.x)): z *= x
            case .mul(.z, .register(.y)): z *= y
            case .mul(.z, .register(.z)): z *= z
            case .mul(.z, .literal(let value)): z *= value


            case .div(.w, .register(.w)): w /= w
            case .div(.w, .register(.x)): w /= x
            case .div(.w, .register(.y)): w /= y
            case .div(.w, .register(.z)): w /= z
            case .div(.w, .literal(let value)): w /= value

            case .div(.x, .register(.w)): x /= w
            case .div(.x, .register(.x)): x /= x
            case .div(.x, .register(.y)): x /= y
            case .div(.x, .register(.z)): x /= z
            case .div(.x, .literal(let value)): x /= value

            case .div(.y, .register(.w)): y /= w
            case .div(.y, .register(.x)): y /= x
            case .div(.y, .register(.y)): y /= y
            case .div(.y, .register(.z)): y /= z
            case .div(.y, .literal(let value)): y /= value

            case .div(.z, .register(.w)): z /= w
            case .div(.z, .register(.x)): z /= x
            case .div(.z, .register(.y)): z /= y
            case .div(.z, .register(.z)): z /= z
            case .div(.z, .literal(let value)): z /= value


            case .mod(.w, .register(.w)): w %= w
            case .mod(.w, .register(.x)): w %= x
            case .mod(.w, .register(.y)): w %= y
            case .mod(.w, .register(.z)): w %= z
            case .mod(.w, .literal(let value)): w %= value

            case .mod(.x, .register(.w)): x %= w
            case .mod(.x, .register(.x)): x %= x
            case .mod(.x, .register(.y)): x %= y
            case .mod(.x, .register(.z)): x %= z
            case .mod(.x, .literal(let value)): x %= value

            case .mod(.y, .register(.w)): y %= w
            case .mod(.y, .register(.x)): y %= x
            case .mod(.y, .register(.y)): y %= y
            case .mod(.y, .register(.z)): y %= z
            case .mod(.y, .literal(let value)): y %= value

            case .mod(.z, .register(.w)): z %= w
            case .mod(.z, .register(.x)): z %= x
            case .mod(.z, .register(.y)): z %= y
            case .mod(.z, .register(.z)): z %= z
            case .mod(.z, .literal(let value)): z %= value


            case .eql(.w, .register(.w)): w = w == w ? 1 : 0
            case .eql(.w, .register(.x)): w = w == x ? 1 : 0
            case .eql(.w, .register(.y)): w = w == y ? 1 : 0
            case .eql(.w, .register(.z)): w = w == z ? 1 : 0
            case .eql(.w, .literal(let value)): w = w == value ? 1 : 0

            case .eql(.x, .register(.w)): x = x == w ? 1 : 0
            case .eql(.x, .register(.x)): x = x == x ? 1 : 0
            case .eql(.x, .register(.y)): x = x == y ? 1 : 0
            case .eql(.x, .register(.z)): x = x == z ? 1 : 0
            case .eql(.x, .literal(let value)): x = x == value ? 1 : 0

            case .eql(.y, .register(.w)): y = y == w ? 1 : 0
            case .eql(.y, .register(.x)): y = y == x ? 1 : 0
            case .eql(.y, .register(.y)): y = y == y ? 1 : 0
            case .eql(.y, .register(.z)): y = y == z ? 1 : 0
            case .eql(.y, .literal(let value)): y = y == value ? 1 : 0

            case .eql(.z, .register(.w)): z = z == w ? 1 : 0
            case .eql(.z, .register(.x)): z = z == x ? 1 : 0
            case .eql(.z, .register(.y)): z = z == y ? 1 : 0
            case .eql(.z, .register(.z)): z = z == z ? 1 : 0
            case .eql(.z, .literal(let value)): z = z == value ? 1 : 0
            }
        }
    }

    public static func validateNumber(_ number: Int, input: String) -> Bool {
        var alu = ALU()
        var number = number
        alu.run(input, input: &number)

        return alu.z == 0
    }
}
