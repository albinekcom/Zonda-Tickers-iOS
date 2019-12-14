import Foundation

struct TickerStatisticsFetcher {
    
    private let endpointString = "https://api.bitbay.net/rest/trading/stats/"
    
    func fetch(for pair: String, completion: @escaping (TickerStatisticsAPIResponse.StatisticsAPIResponse?) -> Void) {
        guard let url = URL(string: "\(endpointString)\(pair)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    completion(nil)
                    
                    return
                }
                
                let tickerFullAPIResponse = try JSONDecoder().decode(TickerStatisticsAPIResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(tickerFullAPIResponse.stats)
                }
            } catch {
                print("Failed to decode: \(error.localizedDescription)")
                
                completion(nil)
            }
        }.resume()
    }
    
}

