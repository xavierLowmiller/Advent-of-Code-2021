import XCTest
@testable import Day9

final class Day9Tests: XCTestCase {
    func testDay9Part1Example() throws {
        let input = """
        2199943210
        3987894921
        9856789892
        8767896789
        9899965678
        """

        let map = DepthMap(input)

        XCTAssertEqual(map.riskLevel, 15)
    }

    func testDay9Part1() throws {
        let map = DepthMap(input)

        print("Day 9 Part 1:", map.riskLevel)
    }

    func testDay9Part2Example() throws {
        let input = """
        2199943210
        3987894921
        9856789892
        8767896789
        9899965678
        """

        let map = DepthMap(input)

        XCTAssertEqual(map.basinValue, 1134)
    }

    func testDay9Part2() throws {
        let map = DepthMap(input)

        print("Day 9 Part 2:", map.basinValue)
    }
}
