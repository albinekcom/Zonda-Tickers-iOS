struct Ticker: Codable, Hashable, Identifiable {
    
    struct Currency: Codable, Hashable, Identifiable {
        
        let id: String
        
        let name: String?
        let precision: Int
        
        init(
            id: String,
            name: String? = nil,
            precision: Int = 2
        ) {
            self.id = id
            self.name = name
            self.precision = precision
        }
        
    }
    
    var id: String { "\(firstCurrency.id)-\(secondCurrency.id)" }
    
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
    
    init(
        firstCurrency: Currency,
        secondCurrency: Currency,
        highestBid: Double? = nil,
        lowestAsk: Double? = nil,
        rate: Double? = nil,
        previousRate: Double? = nil,
        highestRate: Double? = nil,
        lowestRate: Double? = nil,
        volume: Double? = nil,
        average: Double? = nil
    ) {
        self.firstCurrency = firstCurrency
        self.secondCurrency = secondCurrency
        self.highestBid = highestBid
        self.lowestAsk = lowestAsk
        self.rate = rate
        self.previousRate = previousRate
        self.highestRate = highestRate
        self.lowestRate = lowestRate
        self.volume = volume
        self.average = average
    }
    
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

extension Ticker {
    
    var tags: [String] {
        [id,
         firstCurrency.id,
         secondCurrency.id,
         "\(firstCurrency.id)\(secondCurrency.id)",
         "\(firstCurrency.id)\\\(secondCurrency.id)",
         firstCurrency.name?.lowercased(),
         secondCurrency.name?.lowercased()
        ].compactMap { $0 }
    }
    
}

extension Ticker: Comparable {
    
    static func <(lhs: Ticker, rhs: Ticker) -> Bool {
        lhs.secondCurrency.id == rhs.secondCurrency.id ? lhs.firstCurrency.id < rhs.firstCurrency.id : lhs.secondCurrency.id < rhs.secondCurrency.id
    }
    
}
