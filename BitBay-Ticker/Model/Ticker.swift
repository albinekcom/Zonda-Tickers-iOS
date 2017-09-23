import Foundation

struct Ticker {
    
    enum Name: String {
        case btcpln
        case btcusd
        case btceur
        
        case ltcpln
        case ltcusd
        case ltceur
        case ltcbtc
        
        case ethpln
        case ethusd
        case etheur
        case ethbtc
        
        case lskpln
        case lskusd
        case lskeur
        case lskbtc
        
        case bccpln
        case bccusd
        case bcceur
        case bccbtc
        
        case dashpln
        case dashusd
        case dasheur
        case dashbtc
        
        case gamepln
        case gameusd
        case gameeur
        case gamebtc
        
        var baseCurrencyNameLength: Int {
            switch self {
            case .dashpln, .dashusd, .dasheur, .dashbtc,
                 .gamepln, .gameusd, .gameeur, .gamebtc:
                return 4
            default:
                return 3
            }
        }
        
        var counterCurrencyNameLength: Int {
            return 3
        }
    }
    
    struct Key {
        static let name = "name"
        static let max = "max"
        static let min = "min"
        static let last = "last"
        static let bid = "bid"
        static let ask = "ask"
        static let vwap = "vwap"
        static let average = "average"
        static let volume = "volume"
    }
    
    let baseCurrency: Currency
    let counterCurrency: Currency
    
    let name: Name
    let max: Double?
    let min: Double?
    let last: Double?
    let bid: Double?
    let ask: Double?
    let vwap: Double?
    let average: Double?
    let volume: Double?
    
    init?(name: Name, jsonDictionary: [String: Any]?) {
        guard let baseCurrency = Currency(rawValue: String(name.rawValue.characters.dropLast(name.counterCurrencyNameLength))) else { return nil }
        self.baseCurrency = baseCurrency
        
        guard let counterCurrency = Currency(rawValue: String(name.rawValue.characters.dropFirst(name.baseCurrencyNameLength))) else { return nil }
        self.counterCurrency = counterCurrency
        
        self.name = name
        
        max = jsonDictionary?[Key.max] as? Double
        min = jsonDictionary?[Key.min] as? Double
        last = jsonDictionary?[Key.last] as? Double
        bid = jsonDictionary?[Key.bid] as? Double
        ask = jsonDictionary?[Key.ask] as? Double
        vwap = jsonDictionary?[Key.vwap] as? Double
        average = jsonDictionary?[Key.average] as? Double
        volume = jsonDictionary?[Key.volume] as? Double
    }
    
    // MARK: - Loading from saved Plist
    
    var dictionary: [String: Any] {
        return [
            Key.name: name.rawValue as Any,
            Key.max: max as Any,
            Key.min: min as Any,
            Key.last: last as Any,
            Key.bid: bid as Any,
            Key.ask: ask as Any,
            Key.vwap: vwap as Any,
            Key.average: average as Any,
            Key.volume: volume as Any
        ]
    }
    
    init?(fromDictionary dictionary: [String: Any]) {
        guard let nameString = dictionary[Key.name] as? String else { return nil }
        guard let name = Name(rawValue: nameString) else { return nil }
        
        self.init(name: name, jsonDictionary: dictionary)
    }
    
}

extension Ticker {
    
    var prettyName: String {
        let baseCurrencyString = baseCurrency.rawValue.uppercased()
        let counterCurrencyString = counterCurrency.rawValue.uppercased()
        
        return "\(baseCurrencyString)/\(counterCurrencyString)"
    }
    
    var difference: Double? {
        guard let last = last, let vwap = vwap else { return nil }
        
        return last - vwap
    }
    
    var differenceRatio: Double? {
        guard let difference = difference, let vwap = vwap else { return nil }
        
        return difference / vwap
    }
    
    var differenceRatioInPercantage: Double? {
        guard let differenceRatio = differenceRatio else { return nil }
        
        return differenceRatio * 100
    }
    
}
