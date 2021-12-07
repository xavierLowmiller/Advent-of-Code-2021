extension Array where Element == Int {
    private var median: Int {
        sorted()[count / 2]
    }

    var fuelConsumptionToMedian: Int {
        let median = self.median
        return reduce(0) { $0 + abs(median - $1) }
    }

    var fuelConsumptionToCommonClosestPoint: Int {
        guard let min = self.min(),
              let max = self.max()
        else { return 0 }

        return (min...max).map { p in
            reduce(0) { $0 + abs(p - $1).triangular }
        }.min()!
    }
}

private extension Int {
    var triangular: Int {
        return (self * (self + 1)) / 2
    }
}
