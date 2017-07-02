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
    
    let baseCurrency: String
    let counterCurrency: String
    
    let name: Name
    
    let max: Double?
    let min: Double?
    let last: Double?
    let bid: Double?
    let ask: Double?
    let vwap: Double?
    let average: Double?
    let volume: Double?
    
    public init(name: Name, jsonDictionary: [String: Any]?) {
        baseCurrency = String(name.rawValue.uppercased().characters.dropLast(3))
        counterCurrency = String(name.rawValue.uppercased().characters.dropFirst(3))
        
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
    
}
