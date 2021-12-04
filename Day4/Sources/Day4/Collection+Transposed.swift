extension Collection where Iterator.Element: Collection, Iterator.Element.Index == Index {
    var transposed: [[Iterator.Element.Iterator.Element]] {
        indices.map { index in map { $0[index] } }
    }
}
