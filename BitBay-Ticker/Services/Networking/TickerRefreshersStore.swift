final class TickerRefreshersStore {
    
    private var store: [String: TickerRefresher] = [String: TickerRefresher]()
    
    func tickersRefresher(for ticker: Ticker) -> TickerRefresher {
        let refresher: TickerRefresher
        
        if let refresherFromStore = store[ticker.id] {
            refresher = refresherFromStore
        } else {
            refresher = TickerRefresher(ticker: ticker)
            store[ticker.id] = refresher
        }
        
        refresher.ticker = ticker
        
        return refresher
    }
    
    
}
