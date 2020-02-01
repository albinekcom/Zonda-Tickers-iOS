import Foundation

struct TickerStatisticsFetcher {
    
    func fetch(for pair: String, completion: @escaping (Result<TickerStatisticsAPIResponse.StatisticsAPIResponse?, Error>) -> Void) {
        guard let url = URL(string: "\(AppConfiguration.Endpoint.tickerStatistics)\(pair)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                    
                    return
                }
                
                let tickerFullAPIResponse = try JSONDecoder().decode(TickerStatisticsAPIResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(tickerFullAPIResponse.stats))
                }
            } catch {
                print("Failed to decode: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
