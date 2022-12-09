@testable import Zonda_Tickers

final class LocalDataServicePartialSpy: LocalDataService {
    
    private(set) var saveUserTickerIdsInvoked = false
    private(set) var saveTickersInvoked = false
    
    func loadUserTickerIds() -> [String] {
        ["btc-pln", "xxx-zzz"]
    }
    
    func loadTickers() -> [Ticker] {
        [.stub1, .stub3]
    }
    
    func save(userTickerIds: [String]) {
        saveUserTickerIdsInvoked = true
    }
    
    func save(tickers: [Ticker]) {
        saveTickersInvoked = true
    }
    
}
