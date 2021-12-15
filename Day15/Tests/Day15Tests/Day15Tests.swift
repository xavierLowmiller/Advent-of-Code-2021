import XCTest
@testable import Day15

final class Day15Tests: XCTestCase {
    func testDay15Part1Example() throws {
        let input = """
        1163751742
        1381373672
        2136511328
        3694931569
        7463417111
        1319128137
        1359912421
        3125421639
        1293138521
        2311944581
        """

        let caveSystem = CaveSystem(input)

        XCTAssertEqual(caveSystem.lowestTotalRiskPath, 40)
    }

    func testDay15Part1() throws {
        let caveSystem = CaveSystem(input)

        print("Day 15, Part 1:", caveSystem.lowestTotalRiskPath)
    }

    func testDay15Part2Example() throws {
        let input = """
        1163751742
        1381373672
        2136511328
        3694931569
        7463417111
        1319128137
        1359912421
        3125421639
        1293138521
        2311944581
        """

        let caveSystem = CaveSystem(input, fullMap: true)

        XCTAssertEqual(caveSystem.lowestTotalRiskPath, 315)
    }

    func testDay15Part2() throws {
        let caveSystem = CaveSystem(input, fullMap: true)

        print("Day 15, Part 2:", caveSystem.lowestTotalRiskPath)
    }
}
