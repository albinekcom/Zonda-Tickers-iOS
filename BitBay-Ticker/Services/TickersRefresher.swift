import Combine
import Foundation

final class TickersRefresher {
    
    private var cancellable: AnyCancellable?
    
    func refresh(ticker: Ticker, completionHandler: @escaping (Result<Ticker, Error>) -> Void) {
        guard let valuesURL = URL(string: "\(AppConfiguration.Endpoint.tickerValues)\(ticker.id)") else { return }
        guard let statisticsURL = URL(string: "\(AppConfiguration.Endpoint.tickerValues)\(ticker.id)") else { return }
        
        var refreshedTicker = ticker

        let valuesPublisher = URLSession.shared.dataTaskPublisher(for: valuesURL)
            .map { $0.data }
            .decode(type: TickerValuesAPIResponse.self, decoder: JSONDecoder())

        let statisticsPublisher = URLSession.shared.dataTaskPublisher(for: statisticsURL)
            .map { $0.data }
            .decode(type: TickerStatisticsAPIResponse.self, decoder: JSONDecoder())

        self.cancellable = Publishers.Zip(valuesPublisher, statisticsPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        completionHandler(.success(refreshedTicker))
                    case .failure(let error):
                        completionHandler(.failure(error))
                }
            }, receiveValue: { tickerValuesAPIResponse, tickerStatisticsAPIResponse in
                refreshedTicker.updateValues(from: tickerValuesAPIResponse)
                refreshedTicker.updateStatistics(from: tickerStatisticsAPIResponse)
            })
    }
    
    func refresh(tickers: [Ticker]) {
        // TODO: Implement it later
    }
    
}
