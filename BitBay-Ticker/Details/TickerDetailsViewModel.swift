import Foundation

struct TickerDetailsViewModel {
    
    let model: Ticker

    var name: String {
        return "\(model.baseCurrency)/\(model.counterCurrency)"
    }
    
    var values: [TickerDetailViewModelValue] {
        return [
            TickerDetailViewModelValue(title: "Last", value: "\(unwrapValue(model.last)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: "Max", value: "\(unwrapValue(model.max)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: "Min", value: "\(unwrapValue(model.min)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: "Bid", value: "\(unwrapValue(model.bid)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: "Ask", value: "\(unwrapValue(model.ask)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: "Vwap", value: "\(unwrapValue(model.vwap)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: "Average", value: "\(unwrapValue(model.average)) \(model.counterCurrency)"),
            TickerDetailViewModelValue(title: "Volume", value: unwrapValue(model.volume)),
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
