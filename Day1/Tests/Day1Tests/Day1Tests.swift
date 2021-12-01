import XCTest
@testable import Day1

final class Day1Tests: XCTestCase {
    func testDay1Part1Example() throws {
        let input = [
            199,
            200,
            208,
            210,
            200,
            207,
            240,
            269,
            260,
            263
        ]

        XCTAssertEqual(numberOfIncreases(input), 7)
    }

    func testDay1Part1() {
        print("Day 1 Part 1:", numberOfIncreases(input))
    }

    func testDay1Part2Example() throws {
        let input = [
            199,
            200,
            208,
            210,
            200,
            207,
            240,
            269,
            260,
            263
        ]

        XCTAssertEqual(numberOfTripleIncreases(input), 5)
    }

    func testDay1Part2() {
        print("Day 1 Part 2:", numberOfTripleIncreases(input))
    }
}
