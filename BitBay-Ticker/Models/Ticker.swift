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

extension Ticker {
    
    mutating func updateValues(from response: TickerValuesAPIResponse) {
        highestBid = response.ticker?.highestBid.doubleValue
        lowestAsk = response.ticker?.lowestAsk.doubleValue
        rate = response.ticker?.rate.doubleValue
        previousRate = response.ticker?.previousRate.doubleValue
        
        let firstCurrencyResponseFromAPI = response.ticker?.market?.first
        firstCurrency = Ticker.Currency(currency: firstCurrencyResponseFromAPI?.currency, minimumOffer: firstCurrencyResponseFromAPI?.minOffer.doubleValue, scale: firstCurrencyResponseFromAPI?.scale)
        
        let secondCurrencyResponseFromAPI = response.ticker?.market?.second
        secondCurrency = Ticker.Currency(currency: secondCurrencyResponseFromAPI?.currency, minimumOffer: secondCurrencyResponseFromAPI?.minOffer.doubleValue, scale: secondCurrencyResponseFromAPI?.scale)
    }
    
    mutating func updateStatistics(from response: TickerStatisticsAPIResponse) {
        highestRate = response.stats?.h.doubleValue
        lowestRate = response.stats?.l.doubleValue
        volume = response.stats?.v.doubleValue
        average = response.stats?.r24h.doubleValue
    }
    
}
