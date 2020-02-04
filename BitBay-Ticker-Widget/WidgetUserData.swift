import Foundation

final class WidgetUserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    
    weak var todayViewController: TodayViewController?
    
    private let tickersDataLoader: TickersDataLoader = TickersDataLoader()
    private let tickersDataSaver: TickersDataSaver = TickersDataSaver()
    
    private let tickerPropertiesFetcher: TickerPropertiesFetcher = TickerPropertiesFetcher()
    
    init() {
        tickers = tickersDataLoader.loadTickersSynchronously() ?? []
    }
    
    func saveTickers() {
        guard tickers.isEmpty == false else { return }
        
        tickersDataSaver.saveTickers(tickers: tickers)
    }
    
    func refreshTickers(completionHandler: @escaping (Error?) -> ()) {
        tickerPropertiesFetcher.fetch(for: tickers) { [weak self] result in
            switch result {
                case .success(let refreshedTickers):
                    for refreshedTicker in refreshedTickers {
                        if let tickerIndex = self?.tickers.firstIndex(where: { $0.id == refreshedTicker.id }) {
                            self?.tickers[tickerIndex] = refreshedTicker
                        }
                    }
                    
                    /* TODO: Uncomment these lines after integrating "Firebase" framework with this "Today Extension"
                    let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: refreshedTickers)
                    AnalyticsService.shared.trackRefreshedTickers(parameters: analyticsParameters, refresingSource: .widget)
                    */
                
                    completionHandler(nil)
                case .failure(let error):
                    completionHandler(error)
                
//                    AnalyticsService.shared.trackRefreshingTickersFailed() // TODO: Uncomment this line after integrating "Firebase" framework with this "Today Extension"
            }
        }
    }
    
    func launchApplicaiton() {
        guard let applicationURL = WidgetConfiguration.applicationURL else { return }
        
        todayViewController?.extensionContext?.open(applicationURL)
    }
    
}
