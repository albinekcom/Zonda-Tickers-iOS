struct Ticker: Hashable, Codable, Identifiable {
    
    let id: String
    let firstCurrency: Currency?
    let secondCurrency: Currency?
    let highestBid: Double?
    let lowestAsk: Double?
    let rate: Double?
    let previousRate: Double?
    
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
