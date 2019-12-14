struct Ticker: Hashable, Codable, Identifiable, Equatable {
    
    let id: String
    var firstCurrency: Currency?
    var secondCurrency: Currency?
    var highestBid: Double?
    var lowestAsk: Double?
    var rate: Double?
    var previousRate: Double?
    
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
