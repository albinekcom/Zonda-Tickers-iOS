import Foundation

enum Currency: String {
    
    case pln = "PLN"
    case usd = "USD"
    case eur = "EUR"
    
    case btc = "BTC"
    case eth = "ETH"
    case ltc = "LTC"
    case lsk = "LSK"
    
    static var fiatCurrencies: [Currency] {
        return [.pln, .usd, .eur]
    }
    
    var isFiat: Bool {
        return Currency.fiatCurrencies.contains(self)
    }
    
}
