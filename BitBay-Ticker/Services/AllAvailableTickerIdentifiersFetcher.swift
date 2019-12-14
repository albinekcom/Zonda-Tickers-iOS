import Foundation

final class AllAvailableTickerIdentifiersFetcher {
    
    private let urlString = "https://raw.githubusercontent.com/albinekcom/BitBay-API-Tools/master/v1/available-tickers.json"
    
    func fetch(completion: @escaping ([TickerIdentifier]?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    completion(nil)
                    
                    return
                }
                
                let availableTickersAPIResponse = try JSONDecoder().decode(AvailableTickersAPIResponse.self, from: data)
                
                DispatchQueue.main.async {
                    let availableTickerStrings = availableTickersAPIResponse.data?.availableTickers?.map { $0.replacingOccurrences(of: "/", with: "-") }
                    let availableTickerIdentifiers = availableTickerStrings?.compactMap { TickerIdentifier(id: $0) }
                    
                    completion(availableTickerIdentifiers)
                }
            } catch {
                print("Failed to decode: \(error.localizedDescription)")
                
                completion(nil)
            }
        }.resume()
    }
    
}
