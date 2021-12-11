import XCTest
@testable import Day11

final class Day11Tests: XCTestCase {
    func testDay11Part1Example() throws {
        let input = """
        5483143223
        2745854711
        5264556173
        6141336146
        6357385478
        4167524645
        2176841721
        6882881134
        4846848554
        5283751526
        """

        var field = OctopusField(input)

        // After step 1:
        field.step()
        XCTAssertEqual(field.totalFlashes, 0)
        XCTAssertEqual(field.description, """
        6594254334
        3856965822
        6375667284
        7252447257
        7468496589
        5278635756
        3287952832
        7993992245
        5957959665
        6394862637
        """)

        // After step 2:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35)
        XCTAssertEqual(field.description, """
        8807476555
        5089087054
        8597889608
        8485769600
        8700908800
        6600088989
        6800005943
        0000007456
        9000000876
        8700006848
        """)

        // After step 3:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45)
        XCTAssertEqual(field.description, """
        0050900866
        8500800575
        9900000039
        9700000041
        9935080063
        7712300000
        7911250009
        2211130000
        0421125000
        0021119000
        """)

        // After step 4:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45 + 16)
        XCTAssertEqual(field.description, """
        2263031977
        0923031697
        0032221150
        0041111163
        0076191174
        0053411122
        0042361120
        5532241122
        1532247211
        1132230211
        """)

        // After step 5:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45 + 16 + 8)
        XCTAssertEqual(field.description, """
        4484144000
        2044144000
        2253333493
        1152333274
        1187303285
        1164633233
        1153472231
        6643352233
        2643358322
        2243341322
        """)

        // After step 6:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45 + 16 + 8 + 1)
        XCTAssertEqual(field.description, """
        5595255111
        3155255222
        3364444605
        2263444496
        2298414396
        2275744344
        2264583342
        7754463344
        3754469433
        3354452433
        """)

        // After step 7:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45 + 16 + 8 + 1 + 7)
        XCTAssertEqual(field.description, """
        6707366222
        4377366333
        4475555827
        3496655709
        3500625609
        3509955566
        3486694453
        8865585555
        4865580644
        4465574644
        """)

        // After step 8:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45 + 16 + 8 + 1 + 7 + 24)
        XCTAssertEqual(field.description, """
        7818477333
        5488477444
        5697666949
        4608766830
        4734946730
        4740097688
        6900007564
        0000009666
        8000004755
        6800007755
        """)

        // After step 9:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45 + 16 + 8 + 1 + 7 + 24 + 39)
        XCTAssertEqual(field.description, """
        9060000644
        7800000976
        6900000080
        5840000082
        5858000093
        6962400000
        8021250009
        2221130009
        9111128097
        7911119976
        """)

        // After step 10:
        field.step()
        XCTAssertEqual(field.totalFlashes, 35 + 45 + 16 + 8 + 1 + 7 + 24 + 39 + 29)
        XCTAssertEqual(field.description, """
        0481112976
        0031112009
        0041112504
        0081111406
        0099111306
        0093511233
        0442361130
        5532252350
        0532250600
        0032240000
        """)

        for _ in 0..<90 {
            field.step()
        }

        XCTAssertEqual(field.totalFlashes, 1656)
    }

    func testDay11Part1() throws {
        var field = OctopusField(input)

        for _ in 0..<100 {
            field.step()
        }

        print("Day 11 Part 1:", field.totalFlashes)
    }
    func testDay11Part2Example() throws {
        let input = """
        5483143223
        2745854711
        5264556173
        6141336146
        6357385478
        4167524645
        2176841721
        6882881134
        4846848554
        5283751526
        """

        var field = OctopusField(input)

        var stepCount = 0
        while !field.allOctopiJustFlashed {
            field.step()
            stepCount += 1
        }

        XCTAssertEqual(stepCount, 195)
    }

    func testDay11Part2() throws {

        var field = OctopusField(input)

        var stepCount = 0
        while !field.allOctopiJustFlashed {
            field.step()
            stepCount += 1
        }

        print("Day 11 Part 2:", stepCount)
    }
}
