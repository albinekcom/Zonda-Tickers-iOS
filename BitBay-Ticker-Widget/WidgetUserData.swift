import Foundation

final class WidgetUserData: ObservableObject {
    
    @Published var tickers: [Ticker] = []
        
    private let tickersDataLoader: TickersDataLoader = TickersDataLoader()
    private let tickersDataSaver: TickersDataSaver = TickersDataSaver()
    
    private let tickerPropertiesFetcher: TickerPropertiesFetcher = TickerPropertiesFetcher()
    
    init() {
        tickers = tickersDataLoader.loadTickersSynchronously() ?? []
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
                    
                    let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: refreshedTickers)
                    AnalyticsService.shared.trackRefreshedTickers(parameters: analyticsParameters, source: .widget)
                    
                    self?.saveTickers()
                
                    completionHandler(nil)
                case .failure(let error):
                    AnalyticsService.shared.trackRefreshingTickersFailed(source: .widget)
                
                    completionHandler(error)
            }
        }
    }
    
    private func saveTickers() {
        guard tickers.isEmpty == false else { return }
        
        tickersDataSaver.saveTickers(tickers: tickers)
    }
    
}
