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
    
    init(name: Name, jsonDictionary: [String: Any]?) {
        baseCurrency = Currency(rawValue: String(name.rawValue.characters.dropLast(3)))!
        counterCurrency = Currency(rawValue: String(name.rawValue.characters.dropFirst(3)))!
        
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
    
    init(fromDictionary dictionary: [String: Any]) {
        let nameString = dictionary[Key.name] as! String
        
        self.init(name: Name(rawValue: nameString)!, jsonDictionary: dictionary)
    }
    
}
