import XCTest
@testable import Day10

final class Day10Tests: XCTestCase {
    func testDay10Part1Example() throws {
        let input = """
        [({(<(())[]>[[{[]{<()<>>
        [(()[<>])]({[<{<<[]>>(
        {([(<{}[<>[]}>{[]{[(<()>
        (((({<>}<{<{<>}{[]{[]{}
        [[<[([]))<([[{}[[()]]]
        [{[{({}]{}}([{[{{{}}([]
        {<[[]]>}<{[{[{[]{()[[[]
        [<(<(<(<{}))><([]([]()
        <{([([[(<>()){}]>(<<{{
        <{([{{}}[<[[[<>{}]]]>[]]
        """.split(separator: "\n")

        let checker = SyntaxChecker(lines: input)

        XCTAssertEqual(checker.totalSyntaxErrorScore, 26397)
    }

    func testDay10Part1() throws {
        let checker = SyntaxChecker(lines: input)

        print("Day 10 Part 1:", checker.totalSyntaxErrorScore)
    }

    func testDay10Part2Example() throws {
        let input = """
        [({(<(())[]>[[{[]{<()<>>
        [(()[<>])]({[<{<<[]>>(
        {([(<{}[<>[]}>{[]{[(<()>
        (((({<>}<{<{<>}{[]{[]{}
        [[<[([]))<([[{}[[()]]]
        [{[{({}]{}}([{[{{{}}([]
        {<[[]]>}<{[{[{[]{()[[[]
        [<(<(<(<{}))><([]([]()
        <{([([[(<>()){}]>(<<{{
        <{([{{}}[<[[[<>{}]]]>[]]
        """.split(separator: "\n")

        let checker = SyntaxChecker(lines: input)

        XCTAssertEqual(checker.completionScore, 288957)
    }

    func testDay10Part2() throws {
        let checker = SyntaxChecker(lines: input)

        print("Day 10 Part 2:", checker.completionScore)
    }
}
