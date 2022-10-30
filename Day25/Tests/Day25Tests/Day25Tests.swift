import XCTest
@testable import Day25

final class Day25Tests: XCTestCase {
    func testParsingExample1() {
        // Given
        let input = "...>>>>>..."

        // When
        let seafloor = Seafloor(input)

        // Then
        XCTAssertEqual(seafloor.description, input)
    }

    func testParsingExample2() {
        // Given
        let input = """
        ..........
        .>v....v..
        .......>..
        ..........
        """

        // When
        let seafloor = Seafloor(input)

        // Then
        XCTAssertEqual(seafloor.description, input)
    }

    func testStepExample1() {
        // Given
        let input = "...>>>>>..."
        var seafloor = Seafloor(input)

        // When
        seafloor.step()

        // Then
        XCTAssertEqual(seafloor.description, "...>>>>.>..")

        // When
        seafloor.step()

        // Then
        XCTAssertEqual(seafloor.description, "...>>>.>.>.")
    }

    func testStepExample2() {
        // Given
        let input = """
        ..........
        .>v....v..
        .......>..
        ..........
        """
        var seafloor = Seafloor(input)

        // When
        seafloor.step()

        // Then
        XCTAssertEqual(seafloor.description, """
        ..........
        .>........
        ..v....v>.
        ..........
        """)
    }

    func testStepExample3() {
        // Given
        let input = """
        ...>...
        .......
        ......>
        v.....>
        ......>
        .......
        ..vvv..
        """
        var seafloor = Seafloor(input)

        // When 1
        seafloor.step()

        // Then 1
        XCTAssertEqual(seafloor.description, """
        ..vv>..
        .......
        >......
        v.....>
        >......
        .......
        ....v..
        """)

        // When 2
        seafloor.step()

        // Then 2
        XCTAssertEqual(seafloor.description, """
        ....v>.
        ..vv...
        .>.....
        ......>
        v>.....
        .......
        .......
        """)

        // When 3
        seafloor.step()

        // Then 3
        XCTAssertEqual(seafloor.description, """
        ......>
        ..v.v..
        ..>v...
        >......
        ..>....
        v......
        .......
        """)

        // When 4
        seafloor.step()

        // Then 4
        XCTAssertEqual(seafloor.description, """
        >......
        ..v....
        ..>.v..
        .>.v...
        ...>...
        .......
        v......
        """)
    }

    func testSteppingUntilStuck() {
        // Given
        let input = """
        v...>>.vv>
        .vv>>.vv..
        >>.>v>...v
        >>v>>.>.v.
        v>v.vv.v..
        >.>>..v...
        .vv..>.>v.
        v.v..>>v.v
        ....v..v.>
        """
        var seafloor = Seafloor(input)

        // When
        let steps = seafloor.stepUntilStuck()

        // Then
        XCTAssertEqual(steps, 58)
    }

    func testDay25() {
        // Given
        var seafloor = Seafloor(input)

        // When
        let steps = seafloor.stepUntilStuck()

        // Then
        print("Day 25:", steps)
    }
}
