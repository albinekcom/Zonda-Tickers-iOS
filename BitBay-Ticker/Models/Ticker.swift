struct Ticker: Hashable, Codable, Identifiable, Equatable {
    
    struct Currency: Hashable, Codable, Equatable {
        
        let currency: String
        let minimumOffer: Double
        let scale: Int
        
    }
    
    let id: String
    var firstCurrency: Currency?
    var secondCurrency: Currency?
    var highestBid: Double?
    var lowestAsk: Double?
    
    var rate: Double?
    
    var highestRate: Double?
    var lowestRate: Double?
    var volume: Double?
    var average: Double?
    
    var title: String {
        "\(firstCurrencyIdentifier)/\(secondCurrencyIdentifier)"
    }
    
    var firstCurrencyIdentifier: String {
        currencyIdentifier.first ?? ""
    }
    
    var secondCurrencyIdentifier: String {
        currencyIdentifier.last ?? ""
    }
    
    private var currencyIdentifier: [String] {
        id.components(separatedBy: "-")
    }
    
}
