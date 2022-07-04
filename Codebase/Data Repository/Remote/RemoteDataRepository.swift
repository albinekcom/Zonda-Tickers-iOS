import Foundation

private enum Endpoint: String {
    
    case currencies = "https://raw.githubusercontent.com/albinekcom/Zonda-API-Tools/main/v1/currencies.json"
    case ticker = "https://api.zonda.exchange/rest/trading/ticker"
    case stats = "https://api.zonda.exchange/rest/trading/stats"
    
    var url: URL? {
        URL(string: rawValue)
    }
    
}

private enum RemoteDataRepositoryError: Error {
    
    case wrongURL
    
}

final class RemoteDataRepository {
    
    private let urlSession: URLSession
    
    private var cachedCurrenciesNamesAPIResponse: CurrenciesNamesAPIResponse?
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch() async throws -> [Ticker] {
        async let tickersValuesAPIResponse = fetch(TickersValuesAPIResponse.self, from: .ticker)
        async let tickersStatisticsAPIResponse = fetch(TickersStatisticsAPIResponse.self, from: .stats)
        
        let currenciesNamesAPIResponse: CurrenciesNamesAPIResponse
        
        if let cachedCurrenciesNamesAPIResponse = cachedCurrenciesNamesAPIResponse {
            currenciesNamesAPIResponse = cachedCurrenciesNamesAPIResponse
        } else {
            currenciesNamesAPIResponse = try await fetch(CurrenciesNamesAPIResponse.self, from: .currencies)
            cachedCurrenciesNamesAPIResponse = currenciesNamesAPIResponse
        }
        
        return try await tickers(
            tickersValuesAPIResponse: tickersValuesAPIResponse,
            tickersStatisticsAPIResponse: tickersStatisticsAPIResponse
        )
    }
    
    // MARK: - Helpers
    
    private func fetch<T: Decodable>(_ type: T.Type, from endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else { throw RemoteDataRepositoryError.wrongURL }
        
        return try JSONDecoder().decode(
            T.self,
            from: try await urlSession.data(from: url).0
        )
    }
    
    private func tickers(tickersValuesAPIResponse: TickersValuesAPIResponse,
                         tickersStatisticsAPIResponse: TickersStatisticsAPIResponse) -> [Ticker] {
        tickersValuesAPIResponse.items.values.compactMap {
            guard let tickerStatisticsAPIResponseItem = tickersStatisticsAPIResponse.items[$0.market.code] else { return nil }
            
            return Ticker(
                tickerValuesAPIResponseItem: $0,
                tickerStatisticsAPIResponseItem: tickerStatisticsAPIResponseItem,
                firstCurrencyName: cachedCurrenciesNamesAPIResponse?.names[$0.market.first.currency.lowercased()],
                secondCurrencyName: cachedCurrenciesNamesAPIResponse?.names[$0.market.second.currency.lowercased()]
            )
        }
        .sorted()
    }
    
}

private extension Ticker {
    
    init(tickerValuesAPIResponseItem: TickersValuesAPIResponse.Item,
         tickerStatisticsAPIResponseItem: TickersStatisticsAPIResponse.Item,
         firstCurrencyName: String?,
         secondCurrencyName: String?) {
        id = tickerValuesAPIResponseItem.market.code.lowercased()
        highestBid = tickerValuesAPIResponseItem.highestBid.double
        lowestAsk = tickerValuesAPIResponseItem.lowestAsk.double
        rate = tickerValuesAPIResponseItem.rate.double
        previousRate = tickerValuesAPIResponseItem.previousRate.double
        
        highestRate = tickerStatisticsAPIResponseItem.h.double
        lowestRate = tickerStatisticsAPIResponseItem.l.double
        volume = tickerStatisticsAPIResponseItem.v.double
        average = tickerStatisticsAPIResponseItem.r24h.double
        
        firstCurrency = .init(
            id: tickerValuesAPIResponseItem.market.first.currency.lowercased(),
            name: firstCurrencyName,
            precision: tickerValuesAPIResponseItem.market.first.scale
        )
        
        secondCurrency = .init(
            id: tickerValuesAPIResponseItem.market.second.currency.lowercased(),
            name: secondCurrencyName,
            precision: tickerValuesAPIResponseItem.market.second.scale
        )
    }
    
}

private extension Optional where Wrapped == String {
    
    var double: Double? {
        guard let self = self else { return nil }
        
        return Double(self)
    }
    
}
