import Foundation

enum Currency: String {
    
    case pln
    case usd
    case eur
    
    case btc
    case eth
    case ltc
    case lsk
    case bcc
    case dash
    case game
    
    static var fiatCurrencies: [Currency] {
        return [.pln, .usd, .eur]
    }
    
    var isFiat: Bool {
        return Currency.fiatCurrencies.contains(self)
    }
    
}

extension Currency: CustomStringConvertible {
    
    var description: String {
        return rawValue.uppercased()
    }
    
}
