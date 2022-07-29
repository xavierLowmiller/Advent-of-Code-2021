import XCTest
import Day23

final class Day23Tests: XCTestCase {
    func testInputParsing() throws {
        let input = """
        #############
        #...........#
        ###A#B#C#D###
          #D#C#B#A#
          #########
        """

        let cave = AmphipodCave(input)
        XCTAssertEqual(cave.description, """
        #############
        #...........#
        ###A#B#C#D###
          #D#C#B#A#
          #########
        """)
    }

    func testInputParsingPart2() throws {
        let input = """
        #############
        #...........#
        ###A#B#C#D###
          #D#C#B#A#
          #########
        """

        let cave = AmphipodCave(input, part: .part2)
        XCTAssertEqual(cave.description, """
        #############
        #...........#
        ###A#B#C#D###
          #D#C#B#A#
          #D#B#A#C#
          #D#C#B#A#
          #########
        """)
    }

    func testDay23Part1Example() throws {
        let input = """
        #############
        #...........#
        ###B#C#B#D###
          #A#D#C#A#
          #########
        """

        let cave = AmphipodCave(input)

        XCTAssertEqual(cave.costOfSorting(in: .part1), 12521)
    }

    func testDay23Part1() throws {
        print("Day 23, Part 1:")

        let cave = AmphipodCave(input)

        print(cave.costOfSorting(in: .part1))
    }

    func testDay23Part2Example() throws {
        let input = """
        #############
        #...........#
        ###B#C#B#D###
          #A#D#C#A#
          #########
        """
        let cave = AmphipodCave(input, part: .part2)

        XCTAssertEqual(cave.costOfSorting(in: .part2), 44169)
    }

    func testDay23Part2() throws {
        print("Day 23, Part 2:")

        let cave = AmphipodCave(input, part: .part2)

        print(cave.costOfSorting(in: .part2))
    }
}
