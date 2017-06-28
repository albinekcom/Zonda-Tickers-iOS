struct TickerViewModel {
    
    let model: Ticker
    
    var last: String {
        let lastValueString: String
        
        if let last = model.last {
            lastValueString = "\(last)"
        } else {
            lastValueString = "-"
        }
        
        return "\(lastValueString) \(model.counterCurrency)"
    }
    
    var name: String {
        return "\(model.baseCurrency)/\(model.counterCurrency)"
    }
    
}
