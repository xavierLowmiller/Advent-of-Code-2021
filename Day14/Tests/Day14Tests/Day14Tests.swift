import XCTest
@testable import Day14

final class Day14Tests: XCTestCase {
    func testDay14Part1Example() throws {
        let input = """
        NNCB

        CH -> B
        HH -> N
        CB -> H
        NH -> C
        HB -> C
        HC -> B
        HN -> C
        NN -> C
        BH -> H
        NC -> B
        NB -> B
        BN -> B
        BB -> N
        BC -> B
        CC -> N
        CN -> C
        """.components(separatedBy: "\n\n")

        let initialState = input[0]
        let replacementRules = input[1]

        var polymerization = Polymerization(initialState: initialState, replacementRules: replacementRules)

        for _ in 0..<10 {
            polymerization.grow()
        }
        XCTAssertEqual(polymerization.elementDiff, 1588)
    }

    func testDay14Part1() throws {
        let initialState = input[0]
        let replacementRules = input[1]

        var polymerization = Polymerization(initialState: initialState, replacementRules: replacementRules)
        
        for _ in 0..<10 {
            polymerization.grow()
        }

        print("Day 14, Part 1:", polymerization.elementDiff)
    }

    func testDay14Part2Example() throws {
        let input = """
        NNCB

        CH -> B
        HH -> N
        CB -> H
        NH -> C
        HB -> C
        HC -> B
        HN -> C
        NN -> C
        BH -> H
        NC -> B
        NB -> B
        BN -> B
        BB -> N
        BC -> B
        CC -> N
        CN -> C
        """.components(separatedBy: "\n\n")

        let initialState = input[0]
        let replacementRules = input[1]

        var polymerization = Polymerization(initialState: initialState, replacementRules: replacementRules)

        for _ in 0..<40 {
            polymerization.grow()
        }

        XCTAssertEqual(polymerization.elementDiff, 2188189693529)
    }

    func testDay14Part2() throws {
        let initialState = input[0]
        let replacementRules = input[1]

        var polymerization = Polymerization(initialState: initialState, replacementRules: replacementRules)

        for _ in 0..<40 {
            polymerization.grow()
        }

        print("Day 14, Part 2:", polymerization.elementDiff)
    }
}
