struct TickerViewModel {
    
    let model: Ticker
    
    var last: String {
        guard let last = model.last else { return "-" }
        
        return "\(last) \(model.counterCurrency)"
    }
    
    var name: String {
        return "\(model.baseCurrency)/\(model.counterCurrency)"
    }
    
}
