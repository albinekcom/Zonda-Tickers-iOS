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
        
        max = jsonDictionary?["max"] as? Double
        min = jsonDictionary?["min"] as? Double
        last = jsonDictionary?["last"] as? Double
        bid = jsonDictionary?["bid"] as? Double
        ask = jsonDictionary?["ask"] as? Double
        vwap = jsonDictionary?["vwap"] as? Double
        average = jsonDictionary?["average"] as? Double
        volume = jsonDictionary?["volume"] as? Double
    }
    
    // MARK: - Loading from saved Plist
    
    var dictionary: [String: Any] {
        return [
            "name": name.rawValue as Any,
            "max": max as Any,
            "min": min as Any,
            "last": last as Any,
            "bid": bid as Any,
            "ask": ask as Any,
            "vwap": vwap as Any,
            "average": average as Any,
            "volume": volume as Any
        ]
    }
    
    init(fromDictionary dictionary: [String: Any]) {
        let nameString = dictionary["name"] as! String
        
        self.init(name: Name(rawValue: nameString)!, jsonDictionary: dictionary)
    }
    
}
