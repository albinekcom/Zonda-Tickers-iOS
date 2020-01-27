final class DataStorage {
    
    var userData: UserData?
    
    private let tickersLoader: TickersDataLoader = TickersDataLoader()
    private let tickersSaver: TickersDataSaver = TickersDataSaver()
    
    private let dataMigrator: DataMigratorFromV0ToV1 = DataMigratorFromV0ToV1()
    
    func loadUserData() {
        let completion = { [weak self] in
            self?.userData?.areTickersLoaded = true
            self?.userData?.setupRefreshingTimer()
            
            self?.userData?.refreshAllTickers()
            self?.userData?.refreshTickersIdentifiers()
        }
        
        if dataMigrator.isMigrationNeeded {
            dataMigrator.loadTickers() { [weak self] (tickers) in
                self?.userData?.tickers = tickers ?? []
                
                completion()
            }
        } else {
            tickersLoader.loadTickers { [weak self] (tickers) in
                self?.userData?.tickers = tickers ?? []
                
                completion()
            }
        }
    }
    
    func saveUserData() {
        tickersSaver.saveTickers(tickers: userData?.tickers ?? [])
    }
    
}
