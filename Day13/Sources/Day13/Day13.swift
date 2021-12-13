struct Point: Hashable {
    let x: Int
    let y: Int
}

extension Point {
    init<S: StringProtocol>(_ input: S) {
        x = Int(input.split(separator: ",")[0])!
        y = Int(input.split(separator: ",")[1])!
    }
}

enum FoldInstruction {

    case x(Int)
    case y(Int)

    init<S: StringProtocol>(_ input: S) {
        if input.hasPrefix("fold along y=") {
            self = .y(Int(input.split(separator: "=")[1])!)
        } else {
            self = .x(Int(input.split(separator: "=")[1])!)
        }
    }
}

struct Paper {
    var points: Set<Point>

    init(dots: String) {
        points = Set(dots.split(separator: "\n").compactMap(Point.init))
    }

    mutating func performFold<S: StringProtocol>(_ input: S) {
        switch FoldInstruction(input) {
        case .x(let foldingLine):
            points = Set(points.map { point in
                guard point.x > foldingLine else { return point }
                let distance = point.x - foldingLine

                return Point(x: point.x - distance * 2, y: point.y)
            })
        case .y(let foldingLine):
            points = Set(points.map { point in
                guard point.y > foldingLine else { return point }
                let distance = point.y - foldingLine

                return Point(x: point.x, y: point.y - distance * 2)
            })
        }
    }
}

extension Paper: CustomStringConvertible {
    var description: String {
        let maxX = points.map(\.x).max() ?? 0
        let maxY = points.map(\.y).max() ?? 0

        var string = ""
        for y in 0...maxY {
            var line = ""
            for x in 0...maxX {
                line += points.contains(Point(x: x, y: y)) ? "#" : "."
            }
            line += "\n"
            string += line
        }
        return String(string.dropLast())
    }
}
