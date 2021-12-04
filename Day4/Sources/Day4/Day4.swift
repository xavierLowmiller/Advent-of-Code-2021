import Foundation

func findFirstWinningBoard(for input: String) -> Int {
    let (numbers, boards) = parseInput(input)

    for number in numbers {
        for board in boards {
            if let winner = board.markField(number) {
                return winner
            }
        }
    }
    fatalError("No winner found")
}

func findLastWinningBoard(for input: String) -> Int {
    var (numbers, boards) = parseInput(input)

    for number in numbers {
        var winningBoards: [BingoBoard] = []
        for board in boards {
            if let winner = board.markField(number) {
                if boards.count - winningBoards.count == 1 {
                    return winner
                } else {
                    winningBoards.append(board)
                }
            }
        }
        boards.removeAll { board in winningBoards.contains { $0 === board } }
    }
    fatalError("No winner found")
}

private func parseInput(_ input: String) -> ([Int], [BingoBoard]) {
    let parts = input.components(separatedBy: "\n\n")
    let numbers = parts[0].split(separator: ",").compactMap { Int($0) }

    return (numbers, parts.dropFirst().map(BingoBoard.init))
}

private extension BingoBoard {
    convenience init<S: StringProtocol>(string: S) {
        self.init(numbers: string.split(separator: "\n").map {
            $0
                .split(whereSeparator: { $0.isWhitespace })
                .compactMap { Int($0) }
        })
    }
}
