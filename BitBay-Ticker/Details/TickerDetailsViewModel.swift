import Foundation

struct TickerDetailsViewModel: BaseTickerNameViewModel {
    
    let tickerName: Ticker.Name
    
    let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
        self.tickerName = ticker.name
    }
    
    var values: [TickerDetailViewModelValue] {
        return [
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.last", comment: ""), value: "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.last, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.max", comment: ""), value: "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.max, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.min", comment: ""), value: "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.min, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.bid", comment: ""), value: "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.bid, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.ask", comment: ""), value: "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.ask, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.vwap", comment: ""), value: "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.vwap, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.average", comment: ""), value: "\(TextFactory.makeFormattedCurrencyValueString(for: ticker.average, isFiat: ticker.counterCurrency.isFiat)) \(ticker.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.volume", comment: ""), value: TextFactory.makeFormattedCurrencyValueString(for: ticker.volume, isFiat: false))
        ]
    }
    
}

struct TickerDetailViewModelValue {
    
    let title: String
    let value: String
    
}
