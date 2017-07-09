import Foundation

struct TickerViewModel: BaseTickerNameViewModel {
    
    var tickerName: Ticker.Name
    
    let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
        self.tickerName = ticker.name
    }
    
    var last: String {
        let lastValueString: String
        
        if let last = ticker.last {
            lastValueString = "\(last)"
        } else {
            lastValueString = "-"
        }
        
        return "\(lastValueString) \(ticker.counterCurrency)"
    }
    
}
