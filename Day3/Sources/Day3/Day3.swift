func powerConsumption(of report: [String]) -> Int {
    let report = report.map(Array.init)
    return report.gamma * report.epsilon
}

func lifeSupportRating(of report: [String]) -> Int {
    let report = report.map(Array.init)
    return report.oxygenGeneratorRating() * report.co2ScrubberRating()
}

private extension Array where Element == [Character] {
    var gamma: Int {
        let bits = self[0].indices.map(mostCommonBit)

        return Int(String(bits), radix: 2)!
    }

    var epsilon: Int {
        let bits = self[0].indices.map(leastCommonBit)
        return Int(String(bits), radix: 2)!
    }

    func oxygenGeneratorRating(index: Int = 0) -> Int {
        guard count > 1 else { return Int(String(self[0]), radix: 2)! }

        let mostCommonBit = mostCommonBit(at: index)

        return filter { $0[index] == mostCommonBit }
            .oxygenGeneratorRating(index: index + 1)
    }

    func co2ScrubberRating(index: Int = 0) -> Int {
        guard count > 1 else { return Int(String(self[0]), radix: 2)! }

        let leastCommonBit = leastCommonBit(at: index)

        return filter { $0[index] == leastCommonBit }
            .co2ScrubberRating(index: index + 1)
    }

    func mostCommonBit(at index: Int) -> Character {
        var ones: Int = 0
        var zeroes: Int = 0
        for element in self {
            if element[index] == "1" {
                ones += 1
            } else {
                zeroes += 1
            }
        }
        return ones >= zeroes ? "1" : "0"
    }

    func leastCommonBit(at index: Int) -> Character {
        var ones: Int = 0
        var zeroes: Int = 0
        for element in self {
            if element[index] == "1" {
                ones += 1
            } else {
                zeroes += 1
            }
        }
        return ones < zeroes ? "1" : "0"
    }
}
