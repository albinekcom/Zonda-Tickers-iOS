import Foundation

final class TickerWebService: TickerFetcher {
    
    enum Endpoint: String {
        
        case currencies = "https://raw.githubusercontent.com/albinekcom/Zonda-API-Tools/main/v1/currencies.json"
        case ticker = "https://api.zonda.exchange/rest/trading/ticker"
        case stats = "https://api.zonda.exchange/rest/trading/stats"
        
        var url: URL {
            URL(string: rawValue)!
        }
        
    }
    
    private let urlSessionData: URLSessionData
    
    private var cachedCurrenciesNamesAPIResponse: CurrenciesNamesAPIResponse?
    
    init(urlSessionData: URLSessionData = URLSession.shared) {
        self.urlSessionData = urlSessionData
    }
    
    func fetch() async throws -> [Ticker] {
        async let tickersValuesAPIResponse = fetch(TickersValuesAPIResponse.self, from: .ticker)
        async let tickersStatisticsAPIResponse = fetch(TickersStatisticsAPIResponse.self, from: .stats)
        async let currenciesNamesAPIResponse = fetchCurrenciesNamesAPIResponse()
        
        return try await [Ticker].make(
            tickersValuesAPIResponse: tickersValuesAPIResponse,
            tickersStatisticsAPIResponse: tickersStatisticsAPIResponse,
            currenciesNamesAPIResponse: currenciesNamesAPIResponse
        )
    }
    
    private func fetchCurrenciesNamesAPIResponse() async throws -> CurrenciesNamesAPIResponse {
        let currenciesNamesAPIResponse: CurrenciesNamesAPIResponse
        
        if let cachedCurrenciesNamesAPIResponse = cachedCurrenciesNamesAPIResponse {
            currenciesNamesAPIResponse = cachedCurrenciesNamesAPIResponse
        } else {
            currenciesNamesAPIResponse = try await fetch(CurrenciesNamesAPIResponse.self, from: .currencies)
            cachedCurrenciesNamesAPIResponse = currenciesNamesAPIResponse
        }
        
        return currenciesNamesAPIResponse
    }
    
    private func fetch<T: Decodable>(
        _ type: T.Type,
        from endpoint: Endpoint
    ) async throws -> T {
        try JSONDecoder().decode(
            T.self,
            from: try await urlSessionData.data(from: endpoint.url, delegate: nil).0
        )
    }
    
}

private extension Array where Element == Ticker {
    
    static func make(
        tickersValuesAPIResponse: TickersValuesAPIResponse,
        tickersStatisticsAPIResponse: TickersStatisticsAPIResponse,
        currenciesNamesAPIResponse: CurrenciesNamesAPIResponse?
    ) -> [Element] {
        tickersValuesAPIResponse.items.values.compactMap {
            let tickerStatisticsAPIResponseItem = tickersStatisticsAPIResponse.items[$0.market.code]
            
            return Ticker(
                tickerValuesAPIResponseItem: $0,
                tickerStatisticsAPIResponseItem: tickerStatisticsAPIResponseItem,
                firstCurrencyName: currenciesNamesAPIResponse?.names[$0.market.first.currency.lowercased()],
                secondCurrencyName: currenciesNamesAPIResponse?.names[$0.market.second.currency.lowercased()]
            )
        }
        .sorted()
    }
    
}

private extension Ticker {
    
    init(
        tickerValuesAPIResponseItem: TickersValuesAPIResponse.Item,
        tickerStatisticsAPIResponseItem: TickersStatisticsAPIResponse.Item?,
        firstCurrencyName: String?,
        secondCurrencyName: String?
    ) {
        highestBid = tickerValuesAPIResponseItem.highestBid?.double
        lowestAsk = tickerValuesAPIResponseItem.lowestAsk?.double
        rate = tickerValuesAPIResponseItem.rate?.double
        previousRate = tickerValuesAPIResponseItem.previousRate?.double
        
        highestRate = tickerStatisticsAPIResponseItem?.h?.double
        lowestRate = tickerStatisticsAPIResponseItem?.l?.double
        volume = tickerStatisticsAPIResponseItem?.v?.double
        average = tickerStatisticsAPIResponseItem?.r24h?.double
        
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

private extension String {
    
    var double: Double? {
        Double(self)
    }
    
}

protocol URLSessionData {
    
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
    
}

extension URLSession: URLSessionData {}
