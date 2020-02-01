import Combine
import Foundation

final class TickersRefresher {
    
    private var cancellable: AnyCancellable?
    
    func refresh(ticker: Ticker, completionHandler: @escaping (Result<Ticker, Error>) -> Void) {
        var refreshedTicker = ticker
        
        self.cancellable = Publishers.Zip(valuesPublisher(pair: ticker.id), statisticsPublisher(pair: ticker.id))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        completionHandler(.success(refreshedTicker))
                    case .failure(let error):
                        completionHandler(.failure(error))
                }
            }) { (tickerValuesAPIResponse, tickerStatisticsAPIResponse) in
                refreshedTicker.updateValues(from: tickerValuesAPIResponse)
                refreshedTicker.updateStatistics(from: tickerStatisticsAPIResponse)
            }
    }
    
    func refresh(tickers: [Ticker]) {
        // TODO: Implement it later
    }
    
    private func valuesPublisher(pair: String) -> AnyPublisher<TickerValuesAPIResponse, Error> {
        let valuesURL = URL(string: "\(AppConfiguration.Endpoint.tickerValues)\(pair)")!
        
        return URLSession.shared.dataTaskPublisher(for: valuesURL)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: TickerValuesAPIResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func statisticsPublisher(pair: String) -> AnyPublisher<TickerStatisticsAPIResponse, Error> {
        let statisticsURL = URL(string: "\(AppConfiguration.Endpoint.tickerStatistics)\(pair)")!
        
        return URLSession.shared.dataTaskPublisher(for: statisticsURL)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: TickerStatisticsAPIResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
