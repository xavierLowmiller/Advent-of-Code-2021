struct Submarine {
    var horizontalPosition = 0
    var depth = 0
    var aim = 0

    mutating func navigate<S: StringProtocol>(_ command: S) {
        let parts = command.split(separator: " ")
        let direction = parts[0]
        let amount = Int(parts[1])

        switch (direction, amount) {
        case ("forward", let amount?):
            horizontalPosition += amount
        case ("down", let amount?):
            depth += amount
        case ("up", let amount?):
            depth -= amount
        default:
            fatalError()
        }
    }

    mutating func navigateWithAim<S: StringProtocol>(_ command: S) {
        let parts = command.split(separator: " ")
        let direction = parts[0]
        let amount = Int(parts[1])

        switch (direction, amount) {
        case ("forward", let amount?):
            horizontalPosition += amount
            depth += amount * aim
        case ("down", let amount?):
            aim += amount
        case ("up", let amount?):
            aim -= amount
        default:
            fatalError()
        }
    }
}
