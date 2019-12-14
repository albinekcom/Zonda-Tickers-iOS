extension Optional where Wrapped == String {
    
    var intValue: Int? {
        if let self = self {
            return Int(self)
        } else {
            return nil
        }
    }
    
    var doubleValue: Double? {
        if let self = self {
            return Double(self)
        } else {
            return nil
        }
    }
    
}
