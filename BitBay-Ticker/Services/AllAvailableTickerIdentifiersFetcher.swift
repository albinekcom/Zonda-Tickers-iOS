import Foundation

struct AllAvailableTickerIdentifiersFetcher {
    
    private let urlString = "https://raw.githubusercontent.com/albinekcom/BitBay-API-Tools/master/v1/available-tickers.json"
    
    
    func fetch(completion: @escaping (Result<[TickerIdentifier], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
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
                
                let availableTickersAPIResponse = try JSONDecoder().decode(AvailableTickersAPIResponse.self, from: data)
                
                let fullNames = availableTickersAPIResponse.data?.fullNames
                
                let availableTickerIdentifiers = availableTickersAPIResponse.data?.availableTickers?.compactMap { (identifier) -> TickerIdentifier in
                    var tickerIdentifier = TickerIdentifier(id: identifier)
                    tickerIdentifier.firstCurrencyFullName = fullNames?[tickerIdentifier.firstCurrencyIdentifier]
                    tickerIdentifier.secondCurrencyFullName = fullNames?[tickerIdentifier.secondCurrencyIdentifier]
                    
                    return tickerIdentifier
                }
                
                let sortedAvailableTickerIdentifiers: [TickerIdentifier]
                
                if let sortingOrder = availableTickersAPIResponse.data?.sortingOrder, let availableTickerIdentifiers = availableTickerIdentifiers {
                    sortedAvailableTickerIdentifiers = TickerIdentifierSorter.sorted(tickerIdentifiers: availableTickerIdentifiers, sortingOrder: sortingOrder)
                } else {
                    sortedAvailableTickerIdentifiers = availableTickerIdentifiers ?? []
                }
                
                DispatchQueue.main.async {
                    completion(.success(sortedAvailableTickerIdentifiers))
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
