final class TickerService {
    
    private let localDataService: LocalDataService
    private let tickerFetcher: TickerFetcher
    
    init(
        localDataService: LocalDataService = FileManagerDataService(),
        tickerFetcher: TickerFetcher = TickerWebService()
    ) {
        self.localDataService = localDataService
        self.tickerFetcher = tickerFetcher
    }
    
    var loaded: [Ticker] {
        localDataService.loadTickers()
    }
    
    var fetched: [Ticker] {
        
        get async throws {
            let fetchedTickers = try await tickerFetcher.fetch()
            
            localDataService.save(tickers: fetchedTickers)
            
            return fetchedTickers
        }
        
    }
    
}
