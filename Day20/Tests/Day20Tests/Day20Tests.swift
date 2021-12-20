import XCTest
@testable import Day20

final class Day20Tests: XCTestCase {
    func testDay20Part1Example() throws {
        let input = """
        ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

        #..#.
        #....
        ##..#
        ..#..
        ..###
        """.components(separatedBy: "\n\n")

        let algorithm = input[0].map { $0 == "#" ? true : false }
        XCTAssertEqual(algorithm.count, 512)

        var image = Image(input[1])
        XCTAssertEqual(image.data.filter(\.value).count, 10)

        image.enhanceTwice(using: algorithm)

        XCTAssertEqual(image.data.filter(\.value).count, 35)
    }

    func testDay20Part1() throws {
        let input = input.components(separatedBy: "\n\n")

        let algorithm = input[0].map { $0 == "#" ? true : false }
        XCTAssertEqual(algorithm.count, 512)

        var image = Image(input[1])

        image.enhanceTwice(using: algorithm)

        print("Day 20, Part 1:", image.data.filter(\.value).count)
    }

    func testDay20Part2Example() throws {
        let input = """
        ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

        #..#.
        #....
        ##..#
        ..#..
        ..###
        """.components(separatedBy: "\n\n")

        let algorithm = input[0].map { $0 == "#" ? true : false }
        XCTAssertEqual(algorithm.count, 512)

        var image = Image(input[1])
        XCTAssertEqual(image.data.filter(\.value).count, 10)

        for _ in 0..<25 {
            image.enhanceTwice(using: algorithm)
        }

        XCTAssertEqual(image.data.filter(\.value).count, 3351)
    }

    func testDay20Part2() throws {
        let input = input.components(separatedBy: "\n\n")

        let algorithm = input[0].map { $0 == "#" ? true : false }
        XCTAssertEqual(algorithm.count, 512)

        var image = Image(input[1])

        for _ in 0..<25 {
            image.enhanceTwice(using: algorithm)
        }

        print("Day 20, Part 2:", image.data.filter(\.value).count)
    }
}
