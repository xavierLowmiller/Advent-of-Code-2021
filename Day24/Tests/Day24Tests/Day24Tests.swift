import XCTest
import Day24

final class Day24Tests: XCTestCase {
    func testDay24PartExample1() {
        let program = """
        inp x
        mul x -1
        """

        var number = 4

        var alu = ALU()
        alu.run(program, input: &number)
        XCTAssertEqual(alu.x, -4)
    }

    func testDay24PartExample2() {
        let program = """
        inp z
        inp x
        mul z 3
        eql z x
        """

        var number: Int
        var alu = ALU()

        number = 42
        alu.run(program, input: &number)
        XCTAssertEqual(alu.z, 0)

        number = 13
        alu.run(program, input: &number)
        XCTAssertEqual(alu.z, 1)
    }

    func testDay24PartExample3() {
        let program = """
        inp w
        add z w
        mod z 2
        div w 2
        add y w
        mod y 2
        div w 2
        add x w
        mod x 2
        div w 2
        mod w 2
        """

        var number: Int
        var alu = ALU()

        number = 7
        alu.run(program, input: &number)
        XCTAssertEqual(alu.w, 0)
        XCTAssertEqual(alu.x, 1)
        XCTAssertEqual(alu.y, 1)
        XCTAssertEqual(alu.z, 1)

        number = 9
        alu.run(program, input: &number)
        XCTAssertEqual(alu.w, 1)
        XCTAssertEqual(alu.x, 1)
        XCTAssertEqual(alu.y, 1)
        XCTAssertEqual(alu.z, 0)
    }

    func testDay24Part1() {
        XCTAssert(ALU.validateNumber(91897399498995, input: input))
    }

    func testDay24Part2() {
        XCTAssert(ALU.validateNumber(51121176121391, input: input))
    }
}

/**
 x = (z mod 26) + (15/14/11/-13/14/15/-7/10/-12/15/-16/-9/-8/-8) == w ? 0 : 1
 z /=             ( 1/ 1/ 1/ 26/ 1/ 1/26/ 1/ 26/ 1/ 26/26/26/26)
 z *= 25 * x + 1
 z += (w +        ( 4/16/14/  3/11/13/11/ 7/ 12/15/ 13/ 1/15/ 4)) * x


 n1 + 4 - 8    = n14 => n1 - 4  = n14
 n2 + 16 - 8   = n13 => n2 + 8  = n13
 n3 + 14 - 13  = n4  => n3 + 1  = n4
 n5 + 11 - 9   = n12 => n5 + 2  = n12
 n6 + 13 - 7   = n7  => n6 + 6  = n7
 n8 + 7 - 12   = n9  => n8 - 5  = n9
 n10 + 15 - 16 = n11 => n10 - 1 = n11

 max: 91897399498995
 min: 51121176121391
 */
