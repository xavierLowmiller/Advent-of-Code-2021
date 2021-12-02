import XCTest
@testable import Day2

final class Day2Tests: XCTestCase {
    func testDay2Part1Example() throws {
        let input = """
        forward 5
        down 5
        forward 8
        up 3
        down 8
        forward 2
        """.split(separator: "\n")
        var submarine = Submarine()

        for command in input {
            submarine.navigate(command)
        }

        XCTAssertEqual(submarine.horizontalPosition, 15)
        XCTAssertEqual(submarine.depth, 10)
        XCTAssertEqual(submarine.horizontalPosition * submarine.depth, 150)
    }

    func testDay2Part1() throws {
        var submarine = Submarine()

        for command in input.split(separator: "\n") {
            submarine.navigate(command)
        }

        print("Day 2 Part 1:", submarine.horizontalPosition * submarine.depth)
    }

    func testDay2Part2Example() throws {
        let input = """
        forward 5
        down 5
        forward 8
        up 3
        down 8
        forward 2
        """.split(separator: "\n")
        var submarine = Submarine()

        for command in input {
            submarine.navigateWithAim(command)
        }

        XCTAssertEqual(submarine.horizontalPosition, 15)
        XCTAssertEqual(submarine.depth, 60)
        XCTAssertEqual(submarine.horizontalPosition * submarine.depth, 900)
    }

    func testDay2Part2() throws {
        var submarine = Submarine()

        for command in input.split(separator: "\n") {
            submarine.navigateWithAim(command)
        }

        print("Day 2 Part 2:", submarine.horizontalPosition * submarine.depth)
    }
}
