import XCTest
import Day17

final class Day17Tests: XCTestCase {
    func testDay17Part1Example() throws {
        let input = """
        target area: x=20..30, y=-10..-5
        """.parseRanges()

        var totalMaxY = 0
        var bestX = 0
        var bestY = 0

        for y in 0...100 {
            for x in 0...100 {
                var probe = Probe(
                    xVelocity: x,
                    yVelocity: y,
                    xTarget: input.xRange,
                    yTarget: input.yRange
                )

                var didPassBy = false
                var didHitTarget = false
                var maxY = probe.yVelocity

                while !didPassBy {
                    probe.step()

                    maxY = max(maxY, probe.yPosition)

                    if probe.xTarget.contains(probe.xPosition) && probe.yTarget.contains(probe.yPosition) {
                        didHitTarget = true
                    }

                    if probe.xPosition > probe.xTarget.max()! || probe.yPosition < probe.yTarget.min()! {
                        didPassBy = true
                    }
                }

                if didHitTarget && totalMaxY < maxY {
                    totalMaxY = maxY
                    bestX = x
                    bestY = y
                }
            }
        }

        XCTAssertEqual(bestX, 6)
        XCTAssertEqual(bestY, 9)
        XCTAssertEqual(totalMaxY, 45)
    }

    func testDay17Part1() throws {

        var totalMaxY = 0

        for y in 0...100 {
            for x in 0...100 {
                var probe = Probe(
                    xVelocity: x,
                    yVelocity: y,
                    xTarget: input.xRange,
                    yTarget: input.yRange
                )

                var didPassBy = false
                var didHitTarget = false
                var maxY = probe.yVelocity

                while !didPassBy {
                    probe.step()

                    maxY = max(maxY, probe.yPosition)

                    if probe.xTarget.contains(probe.xPosition) && probe.yTarget.contains(probe.yPosition) {
                        didHitTarget = true
                    }

                    if probe.xPosition > probe.xTarget.max()! || probe.yPosition < probe.yTarget.min()! {
                        didPassBy = true
                    }
                }

                if didHitTarget && totalMaxY < maxY {
                    totalMaxY = maxY
                }
            }
        }

        print("Day 17 Part 1:", totalMaxY)
    }

    func testDay17Part2Example() throws {
        let input = """
        target area: x=20..30, y=-10..-5
        """.parseRanges()

        struct Point: Hashable {
            let x: Int
            let y: Int
        }
        var hits: [Point: Bool] = [:]

        for x in 0...100 {
            for y in -50...100 {
                var probe = Probe(
                    xVelocity: x,
                    yVelocity: y,
                    xTarget: input.xRange,
                    yTarget: input.yRange
                )

                var didPassBy = false
                var didHitTarget = false
                var maxY = probe.yVelocity

                while !didPassBy {
                    probe.step()

                    maxY = max(maxY, probe.yPosition)

                    if probe.xTarget.contains(probe.xPosition) && probe.yTarget.contains(probe.yPosition) {
                        didHitTarget = true
                    }

                    if probe.xPosition > probe.xTarget.max()! || probe.yPosition < probe.yTarget.min()! {
                        didPassBy = true
                    }
                }

                if didHitTarget {
                    hits[Point(x: x, y: y)] = true
                }
            }
        }

        XCTAssertEqual(hits.filter(\.value).count, 112)
    }

    func testDay17Part2() throws {
        struct Point: Hashable {
            let x: Int
            let y: Int
        }
        var hits: [Point: Bool] = [:]

        for x in 0...300 {
            for y in -500...200 {
                var probe = Probe(
                    xVelocity: x,
                    yVelocity: y,
                    xTarget: input.xRange,
                    yTarget: input.yRange
                )

                var didPassBy = false
                var didHitTarget = false
                var maxY = probe.yVelocity

                while !didPassBy {
                    probe.step()

                    maxY = max(maxY, probe.yPosition)

                    if probe.xTarget.contains(probe.xPosition) && probe.yTarget.contains(probe.yPosition) {
                        didHitTarget = true
                    }

                    if probe.xPosition > probe.xTarget.max()! || probe.yPosition < probe.yTarget.min()! {
                        didPassBy = true
                    }
                }

                if didHitTarget {
                    hits[Point(x: x, y: y)] = true
                }
            }
        }

        print("Day 17 Part 2:", hits.filter(\.value).count)
    }
}

extension String {
    func parseRanges() -> (xRange: ClosedRange<Int>, yRange: ClosedRange<Int>) {
        let chunks = split(separator: " ")
        let xRange = chunks[2].components(separatedBy: "..").map { $0.filter { $0.isNumber || $0 == "-" } }
        let yRange = chunks[3].components(separatedBy: "..").map { $0.filter { $0.isNumber || $0 == "-" } }

        return (
            Int(xRange[0])!...Int(xRange[1])!,
            Int(yRange[0])!...Int(yRange[1])!
        )
    }
}
