extension Array where Element == Ticker {
    
    func ticker(id: String) -> Ticker? {
        first(where: { $0.id == id })
    }
    
}
