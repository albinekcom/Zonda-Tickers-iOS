import Foundation

struct TickerDetailsViewModel {
    
    let model: Ticker

    var name: String {
        return "\(model.baseCurrency)/\(model.counterCurrency)"
    }
    
    var values: [TickerDetailViewModelValue] {
        return [
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.last", comment: ""), value: "\(unwrapValue(model.last)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.max", comment: ""), value: "\(unwrapValue(model.max)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.min", comment: ""), value: "\(unwrapValue(model.min)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.bid", comment: ""), value: "\(unwrapValue(model.bid)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.ask", comment: ""), value: "\(unwrapValue(model.ask)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.vwap", comment: ""), value: "\(unwrapValue(model.vwap)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.average", comment: ""), value: "\(unwrapValue(model.average)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: NSLocalizedString("ticker.details.volume", comment: ""), value: unwrapValue(model.volume))
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
