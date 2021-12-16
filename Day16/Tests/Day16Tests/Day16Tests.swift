import XCTest
@testable import Day16

final class Day16Tests: XCTestCase {
    func testDay16Part1Example1() throws {
        var input = """
        D2FE28
        """.expandedHexString[...]

        let packet = Packet(&input)

        let expected = Packet(version: 6, kind: .literal(2021))

        XCTAssertEqual(packet, expected)
        XCTAssertEqual(packet.versionSum, 6)
    }

    func testDay16Part1Example2() throws {
        var input = """
        38006F45291200
        """.expandedHexString[...]

        let packet = Packet(&input)

        let expected = Packet(version: 1, kind: .operator(.lessThan, [
            Packet(version: 6, kind: .literal(10)),
            Packet(version: 2, kind: .literal(20))
        ]))

        XCTAssertEqual(packet, expected)
        XCTAssertEqual(packet.versionSum, 9)
    }

    func testDay16Part1Example3() throws {
        var input = """
        EE00D40C823060
        """.expandedHexString[...]

        let packet = Packet(&input)

        let expected = Packet(version: 7, kind: .operator(.maximum, [
            Packet(version: 2, kind: .literal(1)),
            Packet(version: 4, kind: .literal(2)),
            Packet(version: 1, kind: .literal(3))
        ]))

        XCTAssertEqual(packet, expected)
        XCTAssertEqual(packet.versionSum, 14)
    }

    func testDay16Part1Example4() throws {
        var input = """
        8A004A801A8002F478
        """.expandedHexString[...]

        let packet = Packet(&input)

        let expected = Packet(version: 4, kind: .operator(.minimum, [
            Packet(version: 1, kind: .operator(.minimum, [
                Packet(version: 5, kind: .operator(.minimum, [
                    Packet(version: 6, kind: .literal(15))
                ]))
            ]))
        ]))

        XCTAssertEqual(packet, expected)
        XCTAssertEqual(packet.versionSum, 16)
    }

    func testDay16Part1Example5() throws {
        var input = """
        620080001611562C8802118E34
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.versionSum, 12)
    }

    func testDay16Part1Example6() throws {
        var input = """
        C0015000016115A2E0802F182340
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.versionSum, 23)
    }

    func testDay16Part1Example7() throws {
        var input = """
        A0016C880162017C3686B18A3D4780
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.versionSum, 31)
    }

    func testDay16Part1() throws {
        var input = input.expandedHexString[...]

        let packet = Packet(&input)
        print("Day 16 Part 1:", packet.versionSum)
    }

    func testDay16Part2Example1() {
        var input = """
        C200B40A82
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 3)
    }

    func testDay16Part2Example2() {
        var input = """
        04005AC33890
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 54)
    }

    func testDay16Part2Example3() {
        var input = """
        880086C3E88112
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 7)
    }

    func testDay16Part2Example4() {
        var input = """
        CE00C43D881120
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 9)
    }

    func testDay16Part2Example5() {
        var input = """
        D8005AC2A8F0
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 1)
    }

    func testDay16Part2Example6() {
        var input = """
        F600BC2D8F
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 0)
    }

    func testDay16Part2Example7() {
        var input = """
        9C005AC2F8F0
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 0)
    }

    func testDay16Part2Example8() {
        var input = """
        9C0141080250320F1802104A08
        """.expandedHexString[...]

        let packet = Packet(&input)
        XCTAssertEqual(packet.result, 1)
    }

    func testDay16Part2() throws {
        var input = input.expandedHexString[...]

        let packet = Packet(&input)
        print("Day 16 Part 2:", packet.result)
    }
}
