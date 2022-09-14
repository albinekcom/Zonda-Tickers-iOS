protocol LocalDataService {
    
    func loadUserTickersId() -> [String]
    func loadTickers() -> [Ticker]
    
    func save(userTickersId: [String])
    func save(tickers: [Ticker])
    
}
