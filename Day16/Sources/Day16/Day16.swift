struct Packet: Equatable {
    enum Kind: Equatable {
        enum Operation {
            case sum
            case product
            case minimum
            case maximum
            case greaterThan
            case lessThan
            case equalTo

            init<S: StringProtocol>(_ input: S) {
                switch input {
                case "000": self = .sum
                case "001": self = .product
                case "010": self = .minimum
                case "011": self = .maximum
                case "101": self = .greaterThan
                case "110": self = .lessThan
                case "111": self = .equalTo
                default: fatalError()
                }
            }
        }

        case literal(_ value: Int)
        case `operator`(_ operation: Operation, _ subPackets: [Packet])
    }

    let version: Int
    let kind: Kind

    var versionSum: Int {
        switch kind {
        case .literal:
            return version
        case .operator(_, let subPackets):
            return version + subPackets.reduce(0) { $0 + $1.versionSum }
        }
    }

    var result: Int {
        switch kind {
        case .literal(let value):
            return value
        case .operator(let operation, let subPackets):
            let subPackets = subPackets.map(\.result)
            switch operation {
            case .sum:
                return subPackets.reduce(0, +)
            case .product:
                return subPackets.reduce(1, *)
            case .minimum:
                return subPackets.min()!
            case .maximum:
                return subPackets.max()!
            case .greaterThan:
                return subPackets[0] > subPackets[1] ? 1 : 0
            case .lessThan:
                return subPackets[0] < subPackets[1] ? 1 : 0
            case .equalTo:
                return subPackets[0] == subPackets[1] ? 1 : 0
            }
        }
    }
}

extension Packet {
    init(_ input: inout Substring) {

        let version = input.prefix(3)
        input.removeFirst(3)
        self.version = Int(version, radix: 2)!

        let kind = input.prefix(3)
        input.removeFirst(3)

        if kind == "100" {
            // Literal
            self.kind = .literal(Int(bitString: &input))
        } else {
            // Operator
            let lengthTypeId = input.prefix(1)
            input.removeFirst(1)

            let operation = Kind.Operation(kind)

            if lengthTypeId == "0" {
                let lengthString = input.prefix(15)
                input.removeFirst(15)
                let length = Int(lengthString, radix: 2)!

                var subPacketsString = input.prefix(length)
                input.removeFirst(length)

                var packets: [Packet] = []
                while !subPacketsString.isEmpty {
                    packets.append(Packet(&subPacketsString))
                }

                self.kind = .operator(operation, packets)
            } else {
                let amountString = input.prefix(11)
                input.removeFirst(11)
                let amount = Int(amountString, radix: 2)!

                var packets: [Packet] = []
                for _ in 0..<amount {
                    packets.append(Packet(&input))
                }

                self.kind = .operator(operation, packets)
            }
        }
    }
}

private extension Int {
    init(bitString: inout Substring) {
        var group: Substring = ""
        var binary: Substring = ""
        repeat {
            group = bitString.prefix(5)
            bitString.removeFirst(5)
            binary.append(contentsOf: group.suffix(4))
        } while group.first == "1"

        self = Int(binary, radix: 2)!
    }
}
