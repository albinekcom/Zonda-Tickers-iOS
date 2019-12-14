import Combine

final class UserData: ObservableObject {
    
    private let allAvailableTickerIdentifiersFetcher: AllAvailableTickerIdentifiersFetcher = AllAvailableTickerIdentifiersFetcher()
    
    @Published var tickers: [Ticker] = []
    @Published var availableTickersIdentifiersToAdd: [TickerIdentifier] = []
    
    init() {
        setUpFakeTickers()
    }
    
    func refreshAllAvailableTickersIdentifiersToAdd() {
        allAvailableTickerIdentifiersFetcher.load { allAvailableTickersIdentifiers in
            let userTickerIdentifiers = self.tickers.map { TickerIdentifier(id: $0.id) }
            let all = allAvailableTickersIdentifiers ?? []
            
            self.availableTickersIdentifiersToAdd = all.filter { userTickerIdentifiers.contains($0) == false }
        }
    }
    
    func removeAvailableToAddTickerIdentifier(tickerIdentifier: TickerIdentifier) {
        availableTickersIdentifiersToAdd.removeAll { $0 == tickerIdentifier }
    }
    
    func appendTicker(from tickerIdentifier: TickerIdentifier) {
        let ticker = Ticker(id: tickerIdentifier.id, firstCurrency: nil, secondCurrency: nil, highestBid: nil, lowestAsk: nil, rate: nil, previousRate: nil)
        
        tickers.append(ticker)
    }
    
    private func setUpFakeTickers() {
        let firstCurrency1 = Currency(currency: "BTC", minimumOffer: 0.0001, scale: 3)
        let secondCurrency1 = Currency(currency: "PLN", minimumOffer: 0.01, scale: 2)
        let ticker1 = Ticker(id: "BTC-PLN", firstCurrency: firstCurrency1, secondCurrency: secondCurrency1, highestBid: 123, lowestAsk: 456, rate: 789, previousRate: 111.11)
        
        let firstCurrency2 = Currency(currency: "LTC", minimumOffer: 0.0001, scale: 3)
        let secondCurrency2 = Currency(currency: "PLN", minimumOffer: 0.01, scale: 2)
        let ticker2 = Ticker(id: "LTC-PLN", firstCurrency: firstCurrency2, secondCurrency: secondCurrency2, highestBid: 123, lowestAsk: 456, rate: 789, previousRate: 222.22)
        
        let firstCurrency3 = Currency(currency: "BTC", minimumOffer: 0.0001, scale: 3)
        let secondCurrency3 = Currency(currency: "ETH", minimumOffer: 0.01, scale: 2)
        let ticker3 = Ticker(id: "ETH-PLN", firstCurrency: firstCurrency3, secondCurrency: secondCurrency3, highestBid: 123, lowestAsk: 456, rate: 789, previousRate: 333.33)
        
        tickers.append(ticker1)
        tickers.append(ticker2)
        tickers.append(ticker3)
    }
    
}
