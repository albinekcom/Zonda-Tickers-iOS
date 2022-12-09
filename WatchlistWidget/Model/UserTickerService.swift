final class UserTickerService {
    
    private let userTickerIdService = UserTickerIdService()
    private let tickerService = TickerService()
    
    var userTickers: [Ticker] {
        
        get async {
            userTickerIdService.loaded.userTickers(from: await tickers)
        }
        
    }
    
    private var tickers: [Ticker] {
        
        get async {
            (try? await tickerService.fetched) ?? tickerService.loaded
        }
        
    }
    
}
