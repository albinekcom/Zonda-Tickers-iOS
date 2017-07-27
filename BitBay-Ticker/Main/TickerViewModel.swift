import Foundation

struct TickerViewModel: BaseTickerNameViewModel {
    
    let tickerName: Ticker.Name
    
    let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
        self.tickerName = ticker.name
    }
    
    var last: String {
        return "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.last, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"
    }
    
}
