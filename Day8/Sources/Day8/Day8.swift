struct Note {
    let output: [Int]

    var outputValue: Int {
        output.reduce(0) { $0 * 10 + $1 }
    }

    init<S: StringProtocol>(string: S) {
        let inputStrings = string
            .split(separator: "|")[0]
            .split(whereSeparator: \.isWhitespace)
        let outputStrings = string
            .split(separator: "|")[1]
            .split(whereSeparator: \.isWhitespace)

        let display = SevenSegmentDisplay(examples: inputStrings + outputStrings)

        output = outputStrings.compactMap(display.value)
    }
}

struct SevenSegmentDisplay<S: StringProtocol> {
    private var lookUpTable: [Set<Character>: Int] = [:]
    init(examples: [S]) {
        var examples = Set(examples.map(Set.init))
        assert(examples.count == 10)

        var one: Set<Character>!
        var three: Set<Character>!
        var five: Set<Character>!
        var eight: Set<Character>!
        var nine: Set<Character>!

        // Find trivial solutions
        for example in examples {
            switch example.count {
            case 2:
                lookUpTable[example] = 1
                one = example
            case 3:
                lookUpTable[example] = 7
            case 4:
                lookUpTable[example] = 4
            case 7:
                lookUpTable[example] = 8
                eight = example
            default: continue
            }
        }
        examples.subtract(lookUpTable.keys)
        assert(examples.count == 6)

        // Find threes
        for example in examples where example.count == 5 {
            if example.isSuperset(of: one) {
                lookUpTable[example] = 3
                three = example
            }
        }
        examples.subtract(lookUpTable.keys)
        assert(examples.count == 5)

        // Find nines
        for example in examples where example.count == 6 {
            if example.isSuperset(of: three) {
                lookUpTable[example] = 9
                nine = example
            }
        }
        examples.subtract(lookUpTable.keys)
        assert(examples.count == 4)

        // Find twos and fives
        let lowerLeftBit = eight.subtracting(nine)
        for example in examples where example.count == 5 {
            if example.isSuperset(of: lowerLeftBit) {
                lookUpTable[example] = 2
            } else {
                lookUpTable[example] = 5
                five = example
            }
        }
        examples.subtract(lookUpTable.keys)
        assert(examples.count == 2)

        // Find zeroes and sixes
        let topRightBit = eight
            .subtracting(five)
            .subtracting(lowerLeftBit)

        for example in examples {
            if example.isSuperset(of: topRightBit) {
                lookUpTable[example] = 0
            } else {
                lookUpTable[example] = 6
            }
        }
    }

    func value(from string: S) -> Int? {
        lookUpTable[Set(string)]
    }
}
