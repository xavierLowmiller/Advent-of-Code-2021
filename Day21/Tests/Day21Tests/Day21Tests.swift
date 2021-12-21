import XCTest
import Day21

final class Day21Tests: XCTestCase {
    func testDay21Part1Example() throws {
        var game = DiracDice(player1Position: 4, player2Position: 8)

        game.play()

        XCTAssertEqual(game.part1Answer, 739785)
    }

    func testDay21Part1() throws {
        var game = DiracDice(player1Position: 3, player2Position: 7)

        game.play()

        print("Day 21, Part 1:", game.part1Answer)
    }

    func testDay21Part2Example() throws {
        var game = UniverseCloningDiracDice(player1Position: 4, player2Position: 8)

        game.play()

        XCTAssertEqual(game.part2Answer, 444356092776315)
    }

    func testDay21Part2() throws {
        var game = UniverseCloningDiracDice(player1Position: 3, player2Position: 7)

        game.play()

        print("Day 21, Part 2:", game.part2Answer)
    }
}
