indirect enum Node: Equatable, ExpressibleByIntegerLiteral {
    case literal(_ value: Int)
    case pair(Node, Node)

    init(integerLiteral value: IntegerLiteralType) {
        self = .literal(value)
    }
}

extension Node {
    init<S: StringProtocol>(_ input: S) where S.SubSequence == Substring {
        var input = input[...]
        self.init(&input)
    }

    init(_ input: inout Substring) {
        switch input.popFirst() {
        case let c? where c.isNumber:
            self = .literal(c.wholeNumberValue!)
        case "[":
            let left = Node(&input)
            guard input.popFirst() == "," else { fatalError() }
            let right = Node(&input)
            guard input.popFirst() == "]" else { fatalError() }
            self = .pair(left, right)
        case _:
            fatalError()
        }
    }

    @discardableResult
    mutating func explode(height: Int = 0) -> (Int, Int)? {
        assert(height <= 4)

        switch self {
        case let .pair(.literal(left), .literal(right)) where height == 4:
            self = 0
            return (left, right)

        case .literal:
            return nil

        case .pair(var left, var right):
            assert(height < 4)

            if let (l, r) = left.explode(height: height + 1) {
                right.addLeft(r)
                self = .pair(left, right)
                return (l, 0)
            }

            if let (l, r) = right.explode(height: height + 1) {
                left.addRight(l)
                self = .pair(left, right)
                return (0, r)
            }

            self = .pair(left, right)
            return nil
        }
    }

    func split() -> Node {
        switch self {
        case let .literal(value) where value > 9:
            if value.isMultiple(of: 2) {
                return .pair(.literal(value / 2), .literal(value / 2))
            } else {
                return .pair(.literal(value / 2), .literal(value / 2 + 1))
            }

        case .literal:
            return self

        case let .pair(.literal(value), right) where value > 9:
            return .pair(
                .literal(value).split(),
                right
            )

        case let .pair(left, right):
            let l2 = left.split()
            if l2 != left {
                return .pair(l2, right)
            } else {
                return .pair(
                    left.split(),
                    right.split()
                )
            }
        }
    }

    private mutating func addLeft(_ value: Int) {
        switch self {
        case let .literal(l):
            self = .literal(l + value)
        case .pair(var n1, let n2):
            n1.addLeft(value)
            self = .pair(n1, n2)
        }
    }

    private mutating func addRight(_ value: Int) {
        switch self {
        case let .literal(l):
            self = .literal(l + value)
        case .pair(let n1, var n2):
            n2.addRight(value)
            self = .pair(n1, n2)
        }
    }

    var magnitude: Int {
        switch self {
        case .literal(let value):
            return value
        case .pair(let left, let right):
            return 3 * left.magnitude + 2 * right.magnitude
        }
    }

    static func + (lhs: Node, rhs: Node) -> Node {
        var node: Node = .pair(lhs, rhs)

        // Reduction
        var copy = node

        repeat {

            repeat {
                node = copy
                copy.explode()
            } while node != copy
            assert(node == copy)

            copy = copy.split()

        } while node != copy

        assert(node == copy)

        return node
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        switch self {
        case let .literal(value):
            return "\(value)"
        case let .pair(n1, n2):
            return "[\(n1.description),\(n2.description)]"
        }
    }
}
