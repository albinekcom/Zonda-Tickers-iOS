import Foundation

final class WidgetUserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    
    weak var todayViewController: TodayViewController?
    
    private let tickersDataLoader: TickersDataLoader = TickersDataLoader()
    private let tickersDataSaver: TickersDataSaver = TickersDataSaver()
    
    private let tickersRefresher: TickersRefresher = TickersRefresher()
    
    func loadTickers() { // TODO: Use it in a proper place
        tickersDataLoader.loadTickers() { [weak self] (tickers) in
            self?.tickers = tickers ?? []
        }
    }
    
    func saveTickers() { // TODO: Use it in a proper place
        guard tickers.isEmpty == false else { return }
        
        tickersDataSaver.saveTickers(tickers: tickers)
    }
    
    func refreshTickers(completionHandler: @escaping (Error?) -> ()) {
        for (index, ticker) in tickers.enumerated() {
            tickersRefresher.refresh(ticker: ticker) { [weak self] result in
                switch result {
                    case .success(let refreshedTicker):
                        self?.tickers[index] = refreshedTicker
                        self?.saveTickers() // TODO: Move it after creating refreshTickers() in TickersRefresher
                    
                    case .failure(_):
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
