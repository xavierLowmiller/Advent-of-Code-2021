func numberOfIncreases(_ input: [Int]) -> Int {
    zip(input, input.dropFirst()).filter { $0 < $1 }.count
}

func numberOfTripleIncreases(_ input: [Int]) -> Int {
    numberOfIncreases(input.triples)
}

private extension Sequence where Element == Int {
    var triples: [Int] {
        zip(zip(self, self.dropFirst(1)), self.dropFirst(2))
            .map { $0.0 + $0.1 + $1 }
    }
}
