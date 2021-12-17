public struct Probe {
    public var xPosition = 0
    public var yPosition = 0
    public var xVelocity: Int
    public var yVelocity: Int

    public var xTarget: ClosedRange<Int>
    public var yTarget: ClosedRange<Int>

    public init(xPosition: Int = 0, yPosition: Int = 0, xVelocity: Int, yVelocity: Int, xTarget: ClosedRange<Int>, yTarget: ClosedRange<Int>) {
        self.xPosition = xPosition
        self.yPosition = yPosition
        self.xVelocity = xVelocity
        self.yVelocity = yVelocity
        self.xTarget = xTarget
        self.yTarget = yTarget
    }

    public mutating func step() {
        xPosition += xVelocity
        yPosition += yVelocity

        if xVelocity > 0 {
            xVelocity -= 1
        }

        if xVelocity < 0 {
            xVelocity += 1
        }

        yVelocity -= 1
    }
}
