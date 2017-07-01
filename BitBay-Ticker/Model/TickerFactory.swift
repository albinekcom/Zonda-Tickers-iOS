import Foundation
import RxCocoa
import RxSwift

struct TickerFactory {
    
    static func makeObservableTicker(named tickerName: Ticker.Name) -> Observable<Ticker> {
        return Observable
            .just(tickerName)
            .map { (tickerName) -> URL in
                return URL(string: "https://bitbay.net/API/Public/\(tickerName.rawValue)/ticker.json")!
            }
            .map { (url) -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { (request) -> Observable<(HTTPURLResponse, Data)> in
                #if DEBUG
                    return Observable.just((HTTPURLResponse(), "{\"max\":9610,\"min\":9360,\"last\":9400,\"bid\":9400,\"ask\":9420.99,\"vwap\":9479.85,\"average\":9400,\"volume\":552.72541447}".data(using: .utf8)!))
                #else
                    return URLSession.shared.rx.response(request: request)
                #endif
            }
            .map { (_, data) -> [String: Any] in
                guard
                    let jsonObject = try? JSONSerialization.jsonObject(with: data),
                    let result = jsonObject as? [String: Any] else {
                        return [:]
                }
                
                return result
            }
            .map { (jsonDictionary) -> Ticker in
                return Ticker(name: tickerName, jsonDictionary: jsonDictionary)
        }
    }
    
}
