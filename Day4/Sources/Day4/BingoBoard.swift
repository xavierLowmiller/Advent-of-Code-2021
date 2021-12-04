final class BingoBoard {
    struct Field {
        var value: Int
        var isMarked = false
    }
    var rows: [[Field]]

    init(numbers: [[Int]]) {
        rows = numbers.map {
            $0.map {
                Field(value: $0)
            }
        }
    }

    /// Marks a field as completed
    /// - Parameter field: The field that was just drawn
    /// - Returns: The score of the board, if it's a winner
    func markField(_ drawnNumber: Int) -> Int? {
        rows = rows.map { row in
            row.map { field in
                if field.value == drawnNumber {
                    var field = field
                    field.isMarked = true
                    return field
                } else {
                    return field
                }
            }
        }

        if isComplete {
            return score(for: drawnNumber)
        } else {
            return nil
        }
    }

    private var isComplete: Bool {
        // Check horizontal winners
        for row in rows {
            if row.allSatisfy(\.isMarked) {
                return true
            }
        }

        // Check vertical winners
        for column in columns {
            if column.allSatisfy(\.isMarked) {
                return true
            }
        }

        return false
    }

    private var columns: [[Field]] {
        rows.transposed
    }

    func score(for field: Int) -> Int {
        field * rows
            .flatMap { $0 }
            .filter { !$0.isMarked }
            .map(\.value)
            .reduce(0, +)
    }
}
