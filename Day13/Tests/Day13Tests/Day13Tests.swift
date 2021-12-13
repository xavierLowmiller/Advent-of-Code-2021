import XCTest
@testable import Day13

final class Day13Tests: XCTestCase {
    func testDay13Part1Example() throws {
        let input = """
        6,10
        0,14
        9,10
        0,3
        10,4
        4,11
        6,0
        6,12
        4,1
        0,13
        10,12
        3,4
        3,0
        8,4
        1,10
        2,14
        8,10
        9,0

        fold along y=7
        fold along x=5
        """.components(separatedBy: "\n\n")

        var paper = Paper(dots: input[0])

        paper.performFold(input[1].split(separator: "\n")[0])

        XCTAssertEqual(paper.points.count, 17)
    }

    func testDay13Part1() throws {
        let dots = input.components(separatedBy: "\n\n")[0]
        let folds = input.components(separatedBy: "\n\n")[1].split(separator: "\n")

        var paper = Paper(dots: dots)

        paper.performFold(folds[0])
        print("Day 13, Part 1:", paper.points.count)
    }

    func testDay13Part2Example() throws {
        let input = """
        6,10
        0,14
        9,10
        0,3
        10,4
        4,11
        6,0
        6,12
        4,1
        0,13
        10,12
        3,4
        3,0
        8,4
        1,10
        2,14
        8,10
        9,0

        fold along y=7
        fold along x=5
        """

        let dots = input.components(separatedBy: "\n\n")[0]
        let folds = input.components(separatedBy: "\n\n")[1].split(separator: "\n")

        var paper = Paper(dots: dots)

        for fold in folds {
            paper.performFold(fold)
        }

        print("Day 13, Part 2 (Example):", paper.description, separator: "\n")
    }

    func testDay13Part2() throws {
        let dots = input.components(separatedBy: "\n\n")[0]
        let folds = input.components(separatedBy: "\n\n")[1].split(separator: "\n")

        var paper = Paper(dots: dots)

        for fold in folds {
            paper.performFold(fold)
        }

        print("Day 13, Part 2:", paper.description, separator: "\n")
    }
}
