import Foundation

final class UserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    @Published var availableTickersIdentifiersToAdd: [TickerIdentifier] = []
    
    static let userDataTickersFileName = "user_data_tickers.json"
    
    private let allAvailableTickerIdentifiersFetcher = AllAvailableTickerIdentifiersFetcher()
    private let tickerValuesFetcher = TickerValuesFetcher()
    private let tickerStatisticsFetcher = TickerStatisticsFetcher()
    
    // MARK: - Managing
    
    func removeAvailableToAddTickerIdentifier(tickerIdentifier: TickerIdentifier) {
        availableTickersIdentifiersToAdd.removeAll { $0 == tickerIdentifier }
    }
    
    func appendTicker(from tickerIdentifier: TickerIdentifier) {
        let ticker = Ticker(id: tickerIdentifier.id, firstCurrency: nil, secondCurrency: nil, highestBid: nil, lowestAsk: nil, rate: nil)
        
        tickers.append(ticker)
    }
    
    // MARK: - Refreshing
    
    func refreshAllTickers() {
        for ticker in tickers {
            refreshValues(for: ticker)
            refreshStatistics(for: ticker)
        }
    }
    
    func refreshValues(for ticker: Ticker) {
        tickerValuesFetcher.fetch(for: ticker.id) { [weak self] tickerAPIResponse in
            var refreshedTicker = ticker
            
            refreshedTicker.highestBid = Double(tickerAPIResponse?.highestBid ?? "")
            refreshedTicker.lowestAsk = Double(tickerAPIResponse?.lowestAsk ?? "")
            refreshedTicker.rate = Double(tickerAPIResponse?.rate ?? "")
            
            if let index = self?.tickers.firstIndex(of: ticker) {
                self?.tickers[index] = refreshedTicker
            }
        }
    }
    
    func refreshStatistics(for ticker: Ticker) {
        tickerStatisticsFetcher.fetch(for: ticker.id) { [weak self] tickerAPIResponse in
            var refreshedTicker = ticker
            
            refreshedTicker.highestRate = Double(tickerAPIResponse?.h ?? "")
            refreshedTicker.lowestRate = Double(tickerAPIResponse?.l ?? "")
            refreshedTicker.volume = Double(tickerAPIResponse?.v ?? "")
            refreshedTicker.average = Double(tickerAPIResponse?.r24h ?? "")
            
            if let index = self?.tickers.firstIndex(of: ticker) {
                self?.tickers[index] = refreshedTicker
            }
        }
    }
    
    func refreshAllAvailableTickersIdentifiersToAdd() {
        allAvailableTickerIdentifiersFetcher.fetch { [weak self] allAvailableTickersIdentifiers in
            let userTickerIdentifiers = self?.tickers.map { TickerIdentifier(id: $0.id) } ?? []
            let all = allAvailableTickersIdentifiers ?? []
            
            self?.availableTickersIdentifiersToAdd = all.filter { userTickerIdentifiers.contains($0) == false }
        }
    }
    
    // MARK: - Storing
    
    func loadUserData() {
        DispatchQueue.global(qos: .background).async {
            if Storage.fileExists(UserData.userDataTickersFileName, in: .documents) {
                let tickersFromFile = Storage.retrieve(UserData.userDataTickersFileName, from: .documents, as: [Ticker].self)
                
                DispatchQueue.main.async { [weak self] in
                    self?.tickers = tickersFromFile
                }
            }
        }
    }
    
    func saveUserData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            Storage.store(self?.tickers, to: .documents, as: UserData.userDataTickersFileName)
        }
    }
    
}
