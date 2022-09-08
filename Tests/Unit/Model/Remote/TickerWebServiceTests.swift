import XCTest
@testable import Zonda_Tickers

final class TickerWebServiceTests: XCTestCase {
    
    func test_fetch() async throws {
        let tickerWebService = TickerWebService(urlSessionData: URLSessionDataStub())
        
        let fetchResults1 = try await tickerWebService.fetch()
        
        XCTAssertEqual(2, fetchResults1.count)
                
        XCTAssertTrue(fetchResults1.contains(where: { $0.id == "btc-pln" }))
        XCTAssertTrue(fetchResults1.contains(where: { $0.id == "eth-pln" }))
        
        let fetchResults2 = try await tickerWebService.fetch() // NOTE: Second fetch for using cached currencies
        
        XCTAssertEqual(2, fetchResults2.count)
    }
    
}

// MARK: - Helpers

private struct URLSessionDataStub: URLSessionData {
    
    func data(
        from url: URL,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse) {
        let jsonString: String
        
        switch TickerWebService.Endpoint(rawValue: url.absoluteString)! {
        case .currencies:
            jsonString = APIResponseJSONStringStub.currencies
        case .ticker:
            jsonString = APIResponseJSONStringStub.tickersValues
        case .stats:
            jsonString = APIResponseJSONStringStub.tickersStatistics
        }
        
        return (
            jsonString.data(using: .utf8)!,
            URLResponse()
        )
    }
    
    private struct APIResponseJSONStringStub {
        
        static var tickersValues: String {
            """
            {
                "status": "Ok",
                "items": {
                    "BTC-PLN": {
                        "market": {
                            "code": "BTC-PLN",
                            "first": {
                                "currency": "BTC",
                                "scale": 8
                            },
                            "second": {
                                "currency": "PLN",
                                "scale": 2
                            }
                        },
                        "rate": "123.45",
                    },
                    "ETH-PLN": {
                        "market": {
                            "code": "ETH-PLN",
                            "first": {
                                "currency": "ETH",
                                "scale": 8
                            },
                            "second": {
                                "currency": "PLN",
                                "scale": 2
                            }
                        },
                        "rate": "45.67",
                    }
                }
            }
            """
        }
        
        static var tickersStatistics: String {
            """
            {
                "status": "Ok",
                "items": {
                    "BTC-PLN": {
                        "m": "BTC-PLN"
                    },
                    "ETH-PLN": {
                        "m": "ETH-PLN"
                    }
                }
            }
            """
        }
        
        static var currencies: String {
            """
            {
                "names": {
                    "btc": "Bitcoin",
                    "eth": "Ethereum"
                }
            }
            """
        }
        
    }
    
}
