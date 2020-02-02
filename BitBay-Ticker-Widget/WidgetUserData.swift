import Foundation

final class WidgetUserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    
    weak var todayViewController: TodayViewController?
    
    private let tickersDataLoader: TickersDataLoader = TickersDataLoader()
    private let tickersDataSaver: TickersDataSaver = TickersDataSaver()
    
    private let tickerRefreshersStore: TickerRefreshersStore = TickerRefreshersStore()
    
    init() {
        tickers = tickersDataLoader.loadTickersSynchronously() ?? []
    }
    
    func saveTickers() {
        guard tickers.isEmpty == false else { return }
        
        tickersDataSaver.saveTickers(tickers: tickers)
    }
    
    func refreshTickers(completionHandler: @escaping (Error?) -> ()) {
        for (index, ticker) in tickers.enumerated() { // TODO: Invoke completionHandler somewhere
            tickerRefreshersStore.tickersRefresher(for: ticker).refresh() { [weak self] result in
                switch result {
                    case .success(let refreshedTicker):
                        self?.tickers[index] = refreshedTicker
                        self?.saveTickers()
                    
                    case .failure(let error):
                        break
                }
            }
        }
    }
    
    func launchApplicaiton() {
        guard let applicationURL = WidgetConfiguration.applicationURL else { return }
        
        todayViewController?.extensionContext?.open(applicationURL)
    }
    
}
