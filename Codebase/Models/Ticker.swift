struct Ticker: Codable {
    
    struct Currency: Codable {
        
        let id: String
        
        let name: String?
        let precision: Int
        
    }
    
    let id: String
    
    let firstCurrency: Currency
    let secondCurrency: Currency
    
    let highestBid: Double?
    let lowestAsk: Double?
    let rate: Double?
    let previousRate: Double?
    let highestRate: Double?
    let lowestRate: Double?
    let volume: Double?
    let average: Double?
    
}

extension Ticker {
    
    var change: Double? {
        guard let average = average,
              let rate = rate else { return nil }
        
        return rate - average
    }
    
    var changeRatio: Double? {
        guard let change = change,
              let average = average else { return nil }
        
        return change / average
    }
    
    var volumeValue: Double? {
        guard let volume = volume,
              let rate = rate else { return nil }
        
        return volume * rate
    }
    
}

extension Ticker: Equatable {
    
    static func == (lhs: Ticker, rhs: Ticker) -> Bool {
        lhs.id == rhs.id &&
        lhs.highestBid == rhs.highestBid &&
        lhs.lowestAsk == rhs.lowestAsk &&
        lhs.rate == rhs.rate &&
        lhs.previousRate == rhs.previousRate &&
        lhs.highestRate == rhs.highestRate &&
        lhs.lowestRate == rhs.lowestRate &&
        lhs.volume == rhs.volume &&
        lhs.average == rhs.average
    }
    
}

extension Ticker: Comparable {
    
    static func <(lhs: Ticker, rhs: Ticker) -> Bool {
        lhs.secondCurrency.id == rhs.secondCurrency.id ? lhs.firstCurrency.id < rhs.firstCurrency.id : lhs.secondCurrency.id < rhs.secondCurrency.id
    }
    
}

extension Array where Element == Ticker {
    
    subscript(tickerId: String) -> Ticker? {
        first { $0.id == tickerId }
    }
    
}
