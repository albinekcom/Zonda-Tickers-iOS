@testable import Zonda_Tickers

final class TickerFetcherStub: TickerFetcher {
    
    enum CustomError: Error {
        case fetch
    }
    
    enum Variant {
        
        case standard
        case error
        
    }
    
    var variant: Variant = .standard
    
    func fetch() async throws -> [Ticker] {
        switch variant {
        case .standard:
            return [.stub1, .stub2]
            
        case .error:
            throw CustomError.fetch
        }
    }
    
}
