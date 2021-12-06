import XCTest
@testable import Day6

final class Day6Tests: XCTestCase {
    func testSinlgeReproduction1() {
        var school = SchoolOfFish(fish: [3, 4, 3, 1, 2])
        school.reproduce()
        XCTAssertEqual(school.state, [1, 1, 2, 1, 0, 0, 0, 0, 0])
    }

    func testSinlgeReproduction2() {
        var school = SchoolOfFish(fish: [2, 3, 2, 0, 1])
        school.reproduce()
        XCTAssertEqual(school.state, [1, 2, 1, 0, 0, 0, 1, 0, 1])
    }

    func testDay6Part1Example() throws {
        let input = "3,4,3,1,2"
        var school = SchoolOfFish(fish: input.split(separator: ",").compactMap { Int($0) })

        for _ in 0..<80 {
            school.reproduce()
        }

        XCTAssertEqual(school.totalFish, 5934)
    }

    func testDay6Part1() throws {
        var school = SchoolOfFish(fish: input.split(separator: ",").compactMap { Int($0) })

        for _ in 0..<80 {
            school.reproduce()
        }

        print("Day 6, Part 1:", school.totalFish)
    }

    func testDay6Part2Example() throws {
        let input = "3,4,3,1,2"
        var school = SchoolOfFish(fish: input.split(separator: ",").compactMap { Int($0) })

        for _ in 0..<256 {
            school.reproduce()
        }

        XCTAssertEqual(school.totalFish, 26984457539)
    }

    func testDay6Part2() throws {
        var school = SchoolOfFish(fish: input.split(separator: ",").compactMap { Int($0) })

        for _ in 0..<256 {
            school.reproduce()
        }

        print("Day 6, Part 2:", school.totalFish)
    }
}
