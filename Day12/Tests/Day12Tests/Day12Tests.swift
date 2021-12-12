import XCTest
@testable import Day12

final class Day12Tests: XCTestCase {
    func testDay12Part1Example() throws {
        let input = """
        start-A
        start-b
        A-c
        A-b
        b-d
        A-end
        b-end
        """

        let caveSystem = CaveSystem(input)

        XCTAssertEqual(caveSystem.validPaths(canVisitOneCaveTwice: false).count, 10)
    }

    func testDay12Part1() throws {
        let caveSystem = CaveSystem(input)

        print("Day 12, Part 1:", caveSystem.validPaths(canVisitOneCaveTwice: false).count)
    }

    func testDay12Part2Example() throws {
        let input = """
        start-A
        start-b
        A-c
        A-b
        b-d
        A-end
        b-end
        """

        let caveSystem = CaveSystem(input)

        XCTAssertEqual(caveSystem.validPaths(canVisitOneCaveTwice: true).count, 36)
    }

    func testDay12Part2() throws {
        let caveSystem = CaveSystem(input)

        print("Day 12, Part 2:", caveSystem.validPaths(canVisitOneCaveTwice: true).count)
    }
}
