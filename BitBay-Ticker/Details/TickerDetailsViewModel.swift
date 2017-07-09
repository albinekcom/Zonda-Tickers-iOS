import Foundation

struct TickerDetailsViewModel: BaseTickerNameViewModel {
    
    var tickerName: Ticker.Name
    
    let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
        self.tickerName = ticker.name
    }
    
    var values: [TickerDetailViewModelValue] {
        return [
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.last", comment: ""), value: "\(unwrapValue(ticker.last)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.max", comment: ""), value: "\(unwrapValue(ticker.max)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.min", comment: ""), value: "\(unwrapValue(ticker.min)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.bid", comment: ""), value: "\(unwrapValue(ticker.bid)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.ask", comment: ""), value: "\(unwrapValue(ticker.ask)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.vwap", comment: ""), value: "\(unwrapValue(ticker.vwap)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.average", comment: ""), value: "\(unwrapValue(ticker.average)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.volume", comment: ""), value: unwrapValue(ticker.volume))
        ]
    }
    
    private func unwrapValue(_ value: Double?) -> String {
        let unwrappedValue: String
        
        if let value = value {
            unwrappedValue = "\(value)"
        } else {
            unwrappedValue = "-"
        }
        
        return unwrappedValue
    }
    
}

struct TickerDetailViewModelValue {
    
    let title: String
    let value: String
    
}
