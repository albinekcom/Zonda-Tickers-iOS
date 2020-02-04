import Foundation

final class TickerIdentifiersFetcher {
    
    func fetch(completion: @escaping (Result<[TickerIdentifier], Error>) -> Void) {
        guard let url = URL(string: AppConfiguration.Endpoint.tickerIdentifiers) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    DispatchQueue.main.async {
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.failure(DataError.unwrappingError))
                        }
                    }
                    
                    return
                }
                
                let availableTickersAPIResponse = try JSONDecoder().decode(AvailableTickersAPIResponse.self, from: data)
                
                let fullNames = availableTickersAPIResponse.data?.fullNames
                
                let tickerIdentifiers = availableTickersAPIResponse.data?.availableTickers?.compactMap { (identifier) -> TickerIdentifier in
                    var tickerIdentifier = TickerIdentifier(id: identifier)
                    tickerIdentifier.firstCurrencyFullName = fullNames?[tickerIdentifier.firstCurrencyIdentifier]
                    tickerIdentifier.secondCurrencyFullName = fullNames?[tickerIdentifier.secondCurrencyIdentifier]
                    
                    return tickerIdentifier
                }
                
                let sortedTickerIdentifiers: [TickerIdentifier]
                
                if let sortingOrder = availableTickersAPIResponse.data?.sortingOrder, let tickerIdentifiers = tickerIdentifiers {
                    sortedTickerIdentifiers = TickerIdentifierSorter.sorted(tickerIdentifiers: tickerIdentifiers, sortingOrder: sortingOrder)
                } else {
                    sortedTickerIdentifiers = tickerIdentifiers ?? []
                }
                
                DispatchQueue.main.async {
                    completion(.success(sortedTickerIdentifiers))
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
