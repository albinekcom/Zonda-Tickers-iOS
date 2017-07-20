import Foundation

struct TickerViewModel: BaseTickerNameViewModel {
    
    var tickerName: Ticker.Name
    
    let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
        self.tickerName = ticker.name
    }
    
    var last: String {
        guard let last = ticker.last else { return "- \(ticker.counterCurrency)" }
        
        let lastValueString: String
        
        if ticker.counterCurrency.isFiat {
            lastValueString = String(format: "%.2f", last)
        } else {
            lastValueString = "\(last)"
        }
        
        return "\(lastValueString) \(ticker.counterCurrency)"
    }
    
}
