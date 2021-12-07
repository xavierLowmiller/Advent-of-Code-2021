import XCTest
@testable import Day7

final class Day7Tests: XCTestCase {
    func testDay7Part1Example() throws {
        let input = "16,1,2,0,4,2,7,1,2,14".split(separator: ",").compactMap( { Int($0) })

        XCTAssertEqual(input.fuelConsumptionToMedian, 37)
    }

    func testDay7Part1() throws {
        print("Day 7 Part 1:", input.fuelConsumptionToMedian)
    }

    func testDay7Part2Example() throws {
        let input = "16,1,2,0,4,2,7,1,2,14".split(separator: ",").compactMap( { Int($0) })

        XCTAssertEqual(input.fuelConsumptionToCommonClosestPoint, 168)
    }

    func testDay7Part2() throws {
        print("Day 7 Part 2:", input.fuelConsumptionToCommonClosestPoint)
    }
}
