extension Optional where Wrapped == Double {
    
    var stringColorStyle: StringColorStyle {
        guard let self = self else { return .normal }
        
        if self > 0 {
            return .positive
        } else if self < 0 {
            return .negative
        } else {
            return .neutral
        }
    }
    
}
