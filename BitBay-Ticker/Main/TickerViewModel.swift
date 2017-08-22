import RxDataSources
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
    
    var differenceRatioInPercantage: Double? {
        return ticker.differenceRatioInPercantage
    }
    
}

extension TickerViewModel: IdentifiableType, Equatable {
    
    typealias Identity = String
    
    var identity: String {
        return ticker.name.rawValue
    }
    
}

func == (lhs: TickerViewModel, rhs: TickerViewModel) -> Bool {
    return lhs.tickerName == rhs.tickerName
}
