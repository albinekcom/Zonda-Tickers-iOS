import Foundation

struct AddTickerViewModel {
    
    let tickerName: Ticker.Name
    
    var name: String {
        let baseCurrency = String(tickerName.rawValue.uppercased().characters.dropLast(3))
        let counterCurrency = String(tickerName.rawValue.uppercased().characters.dropFirst(3))
        
        return "\(baseCurrency)/\(counterCurrency)"
    }
    
}
