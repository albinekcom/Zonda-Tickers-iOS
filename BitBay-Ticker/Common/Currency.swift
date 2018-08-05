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
    case btg
    case kzc
    case xrp
    case xin
    case xmr
    case zec
    case gnt
    case omg
    case fto
    case rep
    case bat
    case zrx
    case pay
    
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
