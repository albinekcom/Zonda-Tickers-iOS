extension Optional where Wrapped == String {
    
    var firstCharacter: String {
        String(self?.first ?? "-")
    }
    
}
