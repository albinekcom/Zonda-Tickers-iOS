struct Ticker: Hashable, Codable, Identifiable {
    
    let id: String
    let firstCurrency: Currency
    let secondCurrency: Currency
    let highestBid: Double
    let lowestAsk: Double
    let rate: Double
    let previousRate: Double
    
    var title: String {
        "\(firstCurrency.currency)/\(secondCurrency.currency)"
    }
    
}
