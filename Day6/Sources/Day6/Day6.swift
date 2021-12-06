struct SchoolOfFish {
    private(set) var state: [Int]
    private let maxValue: Int

    init(fish: [Int], maxValue: Int = 8) {
        state = Array(repeating: 0, count: maxValue + 1)
        self.maxValue = maxValue
        for fish in fish {
            state[fish] += 1
        }
    }

    mutating func reproduce() {
        let amountOfNewFish = state[0]
        for key in 0..<maxValue {
            state[key] = state[key + 1]
        }
        state[6] += amountOfNewFish
        state[8] = amountOfNewFish
    }

    var totalFish: Int {
        state.reduce(0, +)
    }
}
