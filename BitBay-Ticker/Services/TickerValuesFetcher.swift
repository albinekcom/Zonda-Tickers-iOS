import Foundation

final class TickerValuesFetcher {
    
    let endpointString = "https://api.bitbay.net/rest/trading/ticker/"
    
    func fetchValues(for pair: String, completion: @escaping (TickerFullAPIResponse.TickerAPIResponse?) -> Void) {
        guard let url = URL(string: "\(endpointString)\(pair)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    completion(nil)
                    
                    return
                }
                
                let tickerFullAPIResponse = try JSONDecoder().decode(TickerFullAPIResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(tickerFullAPIResponse.ticker)
                }
            } catch {
                print("Failed to decode: \(error.localizedDescription)")
                
                completion(nil)
            }
        }.resume()
    }
    
}
