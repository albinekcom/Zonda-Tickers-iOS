struct Ticker: Codable, Equatable, Identifiable {
    
    struct Currency: Codable, Equatable {
        
        var currency: String?
        var minimumOffer: Double?
        var scale: Int?
        
    }
    
    let id: String
    
    var firstCurrency: Currency?
    var secondCurrency: Currency?
    var highestBid: Double?
    var lowestAsk: Double?
    var rate: Double?
    var previousRate: Double?
    var highestRate: Double?
    var lowestRate: Double?
    var volume: Double?
    var average: Double?
    
}
