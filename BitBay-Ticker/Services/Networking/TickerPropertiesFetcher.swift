
import Foundation

enum DataError: Error {
    
    case unwrappingError
    
}

final class TickerPropertiesFetcher {
    
    func fetch(for tickers: [Ticker], completion: @escaping (Result<[Ticker], Error>) -> Void) {
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var sessionDataTasks: [URLSessionDataTask?] = []
        
        var error: Error?
        
        var valuesResponses: [String: TickerValuesAPIResponse] = [:]
        var statisticsResponses: [String: TickerStatisticsAPIResponse] = [:]
        
        for ticker in tickers {
            let valuesTask = refreshingValuesTask(tickerID: ticker.id) { result in
                switch result {
                    case .success(let tickerValuesAPIResponse):
                        valuesResponses[ticker.id] = tickerValuesAPIResponse
                    
                    case .failure(let err):
                       error = err
                }
                
                dispatchGroup.leave()
            }
            
            sessionDataTasks.append(valuesTask)
            
            let statisticsTask = refreshingStatisticsTask(tickerID: ticker.id) { result in
                switch result {
                    case .success(let tickerStatisticsAPIResponse):
                        statisticsResponses[ticker.id] = tickerStatisticsAPIResponse
                    
                    case .failure(let err):
                       error = err
                }
                
                dispatchGroup.leave()
            }

            sessionDataTasks.append(statisticsTask)
        }
        
        for task in sessionDataTasks {
            dispatchGroup.enter()
            task?.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = error {
                completion(.failure(error))
            } else {
                var refreshedTickers: [Ticker] = []
                
                for ticker in tickers {
                    var refreshedTicker = ticker
                    
                    if let valuesResponse = valuesResponses[refreshedTicker.id] {
                        refreshedTicker.updateValues(from: valuesResponse)
                    }
                    
                    if let statisticsReponse = statisticsResponses[refreshedTicker.id] {
                        refreshedTicker.updateStatistics(from: statisticsReponse)
                    }
                    
                    refreshedTickers.append(refreshedTicker)
                }
                
                completion(.success(refreshedTickers))
            }
        }
    }
    
    private func refreshingValuesTask(tickerID: String, completion: @escaping ((Result<TickerValuesAPIResponse, Error>) -> Void)) -> URLSessionDataTask? {
        guard let valuesURL = URL(string: "\(AppConfiguration.Endpoint.tickerValues)\(tickerID)") else {
            return nil
        }
        
        return URLSession.shared.dataTask(with: valuesURL) { (data, response, err) in
            do {
                guard let data = data else {
                    if let err = err {
                        completion(.failure(err))
                    }  else {
                        completion(.failure(DataError.unwrappingError))
                    }
                    
                    return
                }
            
                let tickerValuesAPIResponse = try JSONDecoder().decode(TickerValuesAPIResponse.self, from: data)
                
                completion(.success(tickerValuesAPIResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func refreshingStatisticsTask(tickerID: String, completion: @escaping ((Result<TickerStatisticsAPIResponse, Error>) -> Void)) -> URLSessionDataTask? {
        guard let statisticsURL = URL(string: "\(AppConfiguration.Endpoint.tickerStatistics)\(tickerID)") else {
            return nil
        }
        
        return URLSession.shared.dataTask(with: statisticsURL) { (data, response, err) in
            do {
                guard let data = data else {
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        completion(.failure(DataError.unwrappingError))
                    }
                    
                    return
                }
            
                let tickerStatisticsAPIResponse = try JSONDecoder().decode(TickerStatisticsAPIResponse.self, from: data)
                
                completion(.success(tickerStatisticsAPIResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}
