import XCTest
@testable import Day4

final class TransposedTests: XCTestCase {
    func testDay4Part1Example() throws {
        // Given
        let input = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]
        let expected = [
            [1, 4, 7],
            [2, 5, 8],
            [3, 6, 9]
        ]

        // When
        let transposed = input.transposed

        // Then
        XCTAssertEqual(transposed, expected)
    }
}
