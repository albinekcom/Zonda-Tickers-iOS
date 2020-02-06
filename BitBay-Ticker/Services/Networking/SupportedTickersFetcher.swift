import Foundation

final class SupportedTickersFetcher {
    
    func fetch(completion: @escaping (Result<[TickerIdentifier], Error>) -> Void) {
        guard let url = URL(string: AppConfiguration.Endpoint.supportedTickers) else { return }
        
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
                
                let supportedTickersAPIResponse = try JSONDecoder().decode(SupportedTickersAPIResponse.self, from: data)
                
                let fullNames = supportedTickersAPIResponse.fullNames
                
                let tickerIdentifiers = supportedTickersAPIResponse.supportedTickers?.compactMap { (identifier) -> TickerIdentifier in
                    var tickerIdentifier = TickerIdentifier(id: identifier)
                    tickerIdentifier.firstCurrencyFullName = fullNames?[tickerIdentifier.firstCurrencyIdentifier]
                    tickerIdentifier.secondCurrencyFullName = fullNames?[tickerIdentifier.secondCurrencyIdentifier]
                    
                    return tickerIdentifier
                }
                
                let sortedTickerIdentifiers: [TickerIdentifier]
                
                if let sortingOrder = supportedTickersAPIResponse.sortingOrder, let tickerIdentifiers = tickerIdentifiers {
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
