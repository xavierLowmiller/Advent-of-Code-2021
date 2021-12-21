struct Player {
    var position: Int
    var score = 0
    let winningScore: Int

    mutating func moveForward(by steps: Int) {
        position = (position + steps) % 10
        score += (position == 0) ? 10 : position
    }

    var hasWon: Bool {
        score >= winningScore
    }
}

struct Die {
    private(set) var rolls = 0
    private var currentScore = 1

    mutating func roll() -> Int {
        rolls += 1
        defer { currentScore += 1}
        return currentScore
    }
}

public struct DiracDice {
    var player1: Player
    var player2: Player
    var die = Die()

    public init(player1Position: Int, player2Position: Int) {
        player1 = Player(position: player1Position, winningScore: 1000)
        player2 = Player(position: player2Position, winningScore: 1000)
    }

    public mutating func play() {
        while !player1.hasWon && !player2.hasWon {
            playSingleRound()
        }
    }

    private mutating func playSingleRound() {
        let player1Steps = die.roll() + die.roll() + die.roll()
        player1.moveForward(by: player1Steps)

        guard !player1.hasWon else { return }

        let player2Steps = die.roll() + die.roll() + die.roll()
        player2.moveForward(by: player2Steps)
    }

    public var part1Answer: Int {
        min(player1.score, player2.score) * die.rolls
    }
}

public struct UniverseCloningDiracDice {
    var player1: Player
    var player2: Player

    var subGames: [UniverseCloningDiracDice] = []

    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }

    public init(player1Position: Int, player2Position: Int) {
        player1 = Player(position: player1Position, winningScore: 21)
        player2 = Player(position: player2Position, winningScore: 21)
    }

    public mutating func play(isPlayer1Turn: Bool = true) {
        for result in 3...9 {
            var game = UniverseCloningDiracDice(
                player1: player1,
                player2: player2
            )
            if isPlayer1Turn {
                game.player1.moveForward(by: result)
            } else {
                game.player2.moveForward(by: result)
            }

            if !game.player1.hasWon && !game.player2.hasWon {
                game.play(isPlayer1Turn: !isPlayer1Turn)
            }
            subGames.append(game)
        }
    }

    var amountOfGamesWherePlayer1HasWon: Int {
        if player1.hasWon {
            return 1
        }

        if player2.hasWon {
            return 0
        }

        return subGames.enumerated().reduce(0) {
            let (index, game) = $1
            let factor = (index + 3).amountOfParallelDimensions
            return $0 + game.amountOfGamesWherePlayer1HasWon * factor
        }
    }

    var amountOfGamesWherePlayer2HasWon: Int {
        if player1.hasWon {
            return 0
        }

        if player2.hasWon {
            return 1
        }

        return subGames.enumerated().reduce(0) {
            let (index, game) = $1
            let factor = (index + 3).amountOfParallelDimensions
            return $0 + game.amountOfGamesWherePlayer2HasWon * factor
        }
    }

    public var part2Answer: Int {
        return max(amountOfGamesWherePlayer1HasWon, amountOfGamesWherePlayer2HasWon)
    }
}

private extension Int {
    var amountOfParallelDimensions: Int {
        switch self {
        case 3: return 1
        case 4: return 3
        case 5: return 6
        case 6: return 7
        case 7: return 6
        case 8: return 3
        case 9: return 1
        default: fatalError()
        }
    }
}
