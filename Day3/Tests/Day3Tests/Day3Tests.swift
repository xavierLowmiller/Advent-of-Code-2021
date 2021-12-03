import XCTest
@testable import Day3

final class Day3Tests: XCTestCase {
    func testDay3Part1Example() throws {
        let input = """
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
        """.components(separatedBy: "\n")

        XCTAssertEqual(powerConsumption(of: input), 198)
    }

    func testDay3Part1() throws {
        print("Day 3 Part 1:", powerConsumption(of: input))
    }

    func testDay3Part2Example() throws {
        let input = """
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
        """.components(separatedBy: "\n")

        XCTAssertEqual(lifeSupportRating(of: input), 230)
    }

    func testDay3Part2() throws {
        print("Day 3 Part 2:", lifeSupportRating(of: input))
    }
}
