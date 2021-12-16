extension String {
    /// Expands the hex values to binary
    ///
    /// "AF" -> "10101111"
    var expandedHexString: String {
        map { c in
            switch c {
                case "0": return "0000"
                case "1": return "0001"
                case "2": return "0010"
                case "3": return "0011"
                case "4": return "0100"
                case "5": return "0101"
                case "6": return "0110"
                case "7": return "0111"
                case "8": return "1000"
                case "9": return "1001"
                case "A": return "1010"
                case "B": return "1011"
                case "C": return "1100"
                case "D": return "1101"
                case "E": return "1110"
                case "F": return "1111"
            default: fatalError()
            }
        }.joined()
    }
}
