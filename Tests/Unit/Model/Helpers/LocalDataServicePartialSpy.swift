@testable import Zonda_Tickers

final class LocalDataServicePartialSpy: LocalDataService {
    
    var loadTickersStub: [Ticker] = [.stub1, .stub3]
    
    private(set) var saveUserTickerIdsInvoked = false
    private(set) var saveTickersInvoked = false
    
    func loadUserTickerIds() -> [String] {
        ["btc-pln", "xxx-zzz"]
    }
    
    func loadTickers() -> [Ticker] {
        loadTickersStub
    }
    
    func save(userTickerIds: [String]) {
        saveUserTickerIdsInvoked = true
    }
    
    func save(tickers: [Ticker]) {
        saveTickersInvoked = true
    }
    
}
