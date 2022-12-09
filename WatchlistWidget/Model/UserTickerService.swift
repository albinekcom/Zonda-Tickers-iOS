final class UserTickerService {
    
    private let userTickerIdsService = UserTickerIdsService()
    private let tickerService = TickerService()
    
    var userTickers: [Ticker] {
        
        get async {
            userTickerIdsService.loaded.userTickers(from: await tickers)
        }
        
    }
    
    private var tickers: [Ticker] {
        
        get async {
            (try? await tickerService.fetched) ?? tickerService.loaded
        }
        
    }
    
}
