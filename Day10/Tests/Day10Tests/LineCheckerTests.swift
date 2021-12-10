import XCTest
@testable import Day10

final class LineCheckerTests: XCTestCase {
    func testValidLines() {
        let validLines = """
        ()
        []
        ([])
        {()()()}
        <([{}])>
        [<>({}){}[([])<>]]
        (((((((((())))))))))
        """.split(separator: "\n")

        for line in validLines {
            XCTAssertNil(line.syntaxError)
        }
    }

    func testInvalidLines() {
        let invalidLines = """
        {([(<{}[<>[]}>{[]{[(<()>
        [[<[([]))<([[{}[[()]]]
        [{[{({}]{}}([{[{{{}}([]
        [<(<(<(<{}))><([]([]()
        <{([([[(<>()){}]>(<<{{
        """.split(separator: "\n")

        for line in invalidLines {
            XCTAssertNotNil(line.syntaxError)
        }
    }
}
