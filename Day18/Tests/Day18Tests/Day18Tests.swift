import XCTest
@testable import Day18

final class Day18Tests: XCTestCase {
    func testDay18Part1Parsing() throws {
        let input = """
        [1,2]
        [[1,2],3]
        [9,[8,7]]
        [[1,9],[8,5]]
        [[[[1,2],[3,4]],[[5,6],[7,8]]],9]
        [[[9,[3,8]],[[0,9],6]],[[[3,7],[4,9]],3]]
        [[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]
        """.split(separator: "\n")

        for s in input {
            var s = s
            let expected = s
            let tree = Node(&s)
            XCTAssertEqual(tree.description, expected.description)
        }
    }

    func testDay18Part1Explosion1() throws {
        var input = "[[[[[9,8],1],2],3],4]"[...]

        var tree = Node(&input)

        tree.explode()

        XCTAssertEqual(tree.description, "[[[[0,9],2],3],4]")
    }

    func testDay18Part1Explosion2() throws {
        var input = "[7,[6,[5,[4,[3,2]]]]]"[...]

        var tree = Node(&input)

        tree.explode()

        XCTAssertEqual(tree.description, "[7,[6,[5,[7,0]]]]")
    }

    func testDay18Part1Explosion3() throws {
        var input = "[[6,[5,[4,[3,2]]]],1]"[...]

        var tree = Node(&input)

        tree.explode()

        XCTAssertEqual(tree.description, "[[6,[5,[7,0]]],3]")
    }

    func testDay18Part1Explosion4() throws {
        var input = "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]"[...]

        var tree = Node(&input)

        tree.explode()

        XCTAssertEqual(tree.description, "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]")
    }

    func testDay18Part1Explosion5() throws {
        var input = "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"[...]

        var tree = Node(&input)

        tree.explode()

        XCTAssertEqual(tree.description, "[[3,[2,[8,0]]],[9,[5,[7,0]]]]")
    }

    func testDay18Part1Split1() throws {
        var input = "[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]"[...]

        var tree = Node(&input)

        tree.explode()

        XCTAssertEqual(tree.description, "[[[[0,7],4],[7,[[8,4],9]]],[1,1]]")

        tree.explode()

        XCTAssertEqual(tree.description, "[[[[0,7],4],[15,[0,13]]],[1,1]]")

        tree = tree.split()

        XCTAssertEqual(tree.description, "[[[[0,7],4],[[7,8],[0,13]]],[1,1]]")

        tree = tree.split()

        XCTAssertEqual(tree.description, "[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]")

        tree.explode()

        XCTAssertEqual(tree.description, "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
    }

    func testAddition() throws {
        let cases: [((Node, Node), Node)] = [
            (
                (Node("[[[[9,8],1],2],3]"),
                 Node("4")),
                Node("[[[[0,9],2],3],4]")
            ),
            (
                (Node("7"),
                 Node("[6,[5,[4,[3,2]]]]")),
                Node("[7,[6,[5,[7,0]]]]")
            ),
            (
                (Node("[6,[5,[4,[3,2]]]]"),
                 Node("1")),
                Node("[[6,[5,[7,0]]],3]")
            ),
            (
                (Node("[[[[4,3],4],4],[7,[[8,4],9]]]"),
                 Node("[1,1]")),
                Node("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
            ),
            (
                (Node("[3,[2,[1,[7,3]]]]"),
                 Node("[6,[5,[4,[3,2]]]]")),
                Node("[[3,[2,[8,0]]],[9,[5,[7,0]]]]")
            ),
            (
                (Node("[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]"),
                 Node("[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]")),
                Node("[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]")
            )
        ]

        for ((n1, n2), result) in cases {
            XCTAssertEqual(n1 + n2, result)
        }
    }

    func testMagnitude() throws {
        var input = "[[1,2],[[3,4],5]]"[...]
        let node = Node(&input)

        XCTAssertEqual(node.magnitude, 143)
    }

    func testReduce() throws {
        let input = """
        [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
        [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
        [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
        [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
        [7,[5,[[3,8],[1,4]]]]
        [[2,[2,2]],[8,[8,1]]]
        [2,9]
        [1,[[[9,3],9],[[9,0],[0,7]]]]
        [[[5,[7,4]],7],1]
        [[[[4,2],2],6],[8,7]]
        """.split(separator: "\n").map(Node.init)

        let first = input.first!

        let result = input.dropFirst().reduce(first, +)

        XCTAssertEqual(result.description, "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]")
        XCTAssertEqual(result.magnitude, 3488)
    }

    func testDay18Part1Example() throws {
        let input = """
        [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
        [[[5,[2,8]],4],[5,[[9,9],0]]]
        [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
        [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
        [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
        [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
        [[[[5,4],[7,7]],8],[[8,3],8]]
        [[9,3],[[9,9],[6,[4,9]]]]
        [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
        [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
        """.split(separator: "\n").map(Node.init)

        let first = input.first!

        let result = input.dropFirst().reduce(first, +)

        XCTAssertEqual(result.description, "[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]")
        XCTAssertEqual(result.magnitude, 4140)
    }

    func testDay18Part1() throws {
        let input = input.split(separator: "\n").map(Node.init)

        let first = input.first!

        let result = input.dropFirst().reduce(first, +)

        print("Day 18, Part 1:", result.magnitude)
    }

    func testDay18Part2Example() throws {
        let input = """
        [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
        [[[5,[2,8]],4],[5,[[9,9],0]]]
        [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
        [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
        [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
        [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
        [[[[5,4],[7,7]],8],[[8,3],8]]
        [[9,3],[[9,9],[6,[4,9]]]]
        [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
        [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
        """.split(separator: "\n").map(Node.init)

        var result = 0

        for n1 in input {
            for n2 in input {
                result = max(result, max((n1 + n2).magnitude, (n2 + n1).magnitude))
            }
        }

        XCTAssertEqual(result, 3993)
    }

    func testDay18Part2() throws {
        let input = input.split(separator: "\n").map(Node.init)

        var result = 0

        for n1 in input {
            for n2 in input {
                result = max(result, max((n1 + n2).magnitude, (n2 + n1).magnitude))
            }
        }

        print("Day 18, Part 2:", result.magnitude)
    }
}
