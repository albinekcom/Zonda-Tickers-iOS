protocol TickerFetcher {
    
    func fetch() async throws -> [Ticker]
    
}
