final class ModelData {
    
    private let localStore = LocalStore()
    private let tickerWebService = TickerWebService()
    
    func fetchUserTickers() async -> [Ticker]? {
        guard let userTickersId: [String] = localStore.load(from: .userTickerIds) else { return nil }
        
        let tickers: [Ticker]
        
        if let fetchedTickers = try? await tickerWebService.fetch() {
            tickers = fetchedTickers
            
            localStore.save(fetchedTickers, in: .tickers)
        } else {
            tickers = localStore.load(from: .tickers) ?? []
        }
        
        return userTickersId.compactMap { userTickerId in tickers.first(where: { $0.id == userTickerId }) }
    }
}
