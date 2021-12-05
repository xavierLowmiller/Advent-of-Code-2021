import XCTest
@testable import Day5

final class Day5Tests: XCTestCase {
    func testDay5Part1Example() throws {
        let input = """
        0,9 -> 5,9
        8,0 -> 0,8
        9,4 -> 3,4
        2,2 -> 2,1
        7,0 -> 7,4
        6,4 -> 2,0
        0,9 -> 2,9
        3,4 -> 1,4
        0,0 -> 8,8
        5,5 -> 8,2
        """.components(separatedBy: "\n")

        var map = HydrothermalVentMap(considerDiagonalLines: false)
        for line in input {
            map.addLine(line)
        }

        XCTAssertEqual(map.amountOfMostDangerousPoints, 5)
    }

    func testDay5Part1() throws {
        var map = HydrothermalVentMap(considerDiagonalLines: false)
        for line in input {
            map.addLine(line)
        }

        print("Day 5 Part 1:", map.amountOfMostDangerousPoints)
    }

    func testDay5Part2Example() throws {
        let input = """
        0,9 -> 5,9
        8,0 -> 0,8
        9,4 -> 3,4
        2,2 -> 2,1
        7,0 -> 7,4
        6,4 -> 2,0
        0,9 -> 2,9
        3,4 -> 1,4
        0,0 -> 8,8
        5,5 -> 8,2
        """.components(separatedBy: "\n")

        var map = HydrothermalVentMap(considerDiagonalLines: true)
        for line in input {
            map.addLine(line)
        }

        XCTAssertEqual(map.amountOfMostDangerousPoints, 12)
    }

    func testDay5Part2() throws {
        var map = HydrothermalVentMap(considerDiagonalLines: true)
        for line in input {
            map.addLine(line)
        }

        print("Day 5 Part 2:", map.amountOfMostDangerousPoints)
    }
}
