struct Ticker: Codable, Equatable, Identifiable {
    
    struct Currency: Codable, Equatable {
        
        var currency: String? = nil
        var minimumOffer: Double? = nil
        var scale: Int? = nil
        
    }
    
    let id: String
    
    var firstCurrency: Currency? = nil
    var secondCurrency: Currency? = nil
    var highestBid: Double? = nil
    var lowestAsk: Double? = nil
    var rate: Double? = nil
    var previousRate: Double? = nil
    var highestRate: Double? = nil
    var lowestRate: Double? = nil
    var volume: Double? = nil
    var average: Double? = nil
    
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
