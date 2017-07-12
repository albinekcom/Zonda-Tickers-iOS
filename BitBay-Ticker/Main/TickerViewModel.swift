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
        
        if ticker.counterCurrency == "BTC" {
            lastValueString = "\(last)"
        } else {
            lastValueString = String(format: "%.2f", last)
        }
        
        return "\(lastValueString) \(ticker.counterCurrency)"
    }
    
}
