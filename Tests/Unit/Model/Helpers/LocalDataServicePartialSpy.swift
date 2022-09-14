@testable import Zonda_Tickers

final class LocalDataServicePartialSpy: LocalDataService {
    
    private(set) var saveUserTickersIdInvoked = false
    private(set) var saveTickersInvoked = false
    
    func loadUserTickersId() -> [String] {
        ["btc-pln", "xxx-zzz"]
    }
    
    func loadTickers() -> [Ticker] {
        [.stub, .stub3]
    }
    
    func save(userTickersId: [String]) {
        saveUserTickersIdInvoked = true
    }
    
    func save(tickers: [Ticker]) {
        saveTickersInvoked = true
    }
    
}
