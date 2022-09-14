import Foundation

final class UserTickerService {
    
    private let userTickersIdService = UserTickersIdService()
    private let tickerService = TickerService()
    
    var userTickers: [Ticker] {
        
        get async {
            userTickersId.userTickers(from: await tickers)
        }
        
    }
    
    private var userTickersId: [String] {
        userTickersIdService.loaded
    }
    
    private var tickers: [Ticker] {
        
        get async {
            (try? await tickerService.fetched) ?? tickerService.loaded
        }
        
    }
    
}
