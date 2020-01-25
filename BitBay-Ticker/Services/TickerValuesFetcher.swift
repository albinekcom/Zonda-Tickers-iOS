import Foundation

struct TickerValuesFetcher {
    
    private let endpointString = "https://api.bitbay.net/rest/trading/ticker/"
    
    func fetch(for pair: String, completion: @escaping (Result<TickerValuesAPIResponse.TickerAPIResponse?, Error>) -> Void) {
        guard let url = URL(string: "\(endpointString)\(pair)") else { return }
        
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
                
                let tickerFullAPIResponse = try JSONDecoder().decode(TickerValuesAPIResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(tickerFullAPIResponse.ticker))
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
