import XCTest
@testable import Day5

final class LinePairTests: XCTestCase {
    func testExampleLinePair1() throws {
        let linePair = LinePair(point1: Point("1,1"), point2: Point("3,3"))
        let expected = [Point(x: 1, y: 1), Point(x: 2, y: 2), Point(x: 3, y: 3)]

        XCTAssertEqual(linePair.allPoints(considerDiagonalLines: true), expected)
    }

    func testExampleLinePair2() throws {
        let linePair = LinePair(point1: Point("9,7"), point2: Point("7,9"))
        let expected = [Point(x: 9, y: 7), Point(x: 8, y: 8), Point(x: 7, y: 9)]

        XCTAssertEqual(linePair.allPoints(considerDiagonalLines: true), expected)
    }
}
