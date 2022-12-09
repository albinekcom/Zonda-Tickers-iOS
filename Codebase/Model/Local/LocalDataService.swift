protocol LocalDataService {
    
    func loadUserTickerIds() -> [String]
    func loadTickers() -> [Ticker]
    
    func save(userTickerIds: [String])
    func save(tickers: [Ticker])
    
}
