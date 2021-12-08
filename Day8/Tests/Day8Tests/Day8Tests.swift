import XCTest
@testable import Day8

final class Day8Tests: XCTestCase {
    func testDay8Part1Example() throws {
        let input = """
        be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
        edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
        fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
        fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
        aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
        fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
        dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
        bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
        egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
        gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
        """.split(separator: "\n")

        let notes = input.map(Note.init)
        let trivialNumbers: Set<Int> = [1, 4, 7, 8]
        XCTAssertEqual(notes.flatMap(\.output).filter(trivialNumbers.contains).count, 26)
    }

    func testDay8Part1() throws {
        let notes = input.map(Note.init)
        let trivialNumbers: Set<Int> = [1, 4, 7, 8]
        print("Day 8 Part 1:", notes.flatMap(\.output).filter(trivialNumbers.contains).count)
    }

    func testSevenSegmentDisplay() {
        let input = """
        acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab cdfeb fcadb cdfeb cdbaf
        """.split(separator: " ")

        let display = SevenSegmentDisplay(examples: input)
        XCTAssertEqual(display.value(from: "cagedb"), 0)
        XCTAssertEqual(display.value(from: "ab"), 1)
        XCTAssertEqual(display.value(from: "gcdfa"), 2)
        XCTAssertEqual(display.value(from: "fbcad"), 3)
        XCTAssertEqual(display.value(from: "eafb"), 4)
        XCTAssertEqual(display.value(from: "cdfbe"), 5)
        XCTAssertEqual(display.value(from: "cdfgeb"), 6)
        XCTAssertEqual(display.value(from: "dab"), 7)
        XCTAssertEqual(display.value(from: "acedgfb"), 8)
        XCTAssertEqual(display.value(from: "cefabd"), 9)
    }

    func testDay8Part2ExampleA() throws {
        let input = """
        acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf
        """

        let note = Note(string: input)
        XCTAssertEqual(note.outputValue, 5353)
    }

    func testDay8Part2ExampleB() throws {
        let input = """
        be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
        edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
        fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
        fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
        aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
        fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
        dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
        bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
        egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
        gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
        """.split(separator: "\n")

        let notes = input.map(Note.init)
        XCTAssertEqual(notes.map(\.outputValue).reduce(0, +), 61229)
    }

    func testDay8Part2() throws {
        let notes = input.map(Note.init)
        print("Day 8 Part 2:", notes.map(\.outputValue).reduce(0, +))
    }
}
