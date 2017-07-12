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
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.last", comment: ""), value: "\(unwrapCurrencyValue(ticker.last)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.max", comment: ""), value: "\(unwrapCurrencyValue(ticker.max)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.min", comment: ""), value: "\(unwrapCurrencyValue(ticker.min)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.bid", comment: ""), value: "\(unwrapCurrencyValue(ticker.bid)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.ask", comment: ""), value: "\(unwrapCurrencyValue(ticker.ask)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.vwap", comment: ""), value: "\(unwrapCurrencyValue(ticker.vwap)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.average", comment: ""), value: "\(unwrapCurrencyValue(ticker.average)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.volume", comment: ""), value: unwrapValue(ticker.volume))
        ]
    }
    
    private func unwrapCurrencyValue(_ value: Double?) -> String {
        guard let value = value else { return "-" }
        
        let valueString: String
        
        if ticker.counterCurrency == "BTC" {
            valueString = "\(value)"
        } else {
            valueString = String(format: "%.2f", value)
        }
        
        return "\(valueString)"
    }
    
    private func unwrapValue(_ value: Double?) -> String {
        guard let value = value else { return "-" }
        
        return "\(value)"
    }
    
}

struct TickerDetailViewModelValue {
    
    let title: String
    let value: String
    
}
