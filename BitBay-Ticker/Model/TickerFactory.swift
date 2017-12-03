import Foundation
import RxCocoa
import RxSwift

struct TickerFactory {
    
    static func makeObservableTicker(named tickerName: Ticker.Name) -> Observable<Ticker?> {
        return Observable
            .just(tickerName)
            .map { (tickerName) -> URL in
                return URL(string: "https://bitbay.net/API/Public/\(tickerName.rawValue)/ticker.json")!
            }
            .map { (url) -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { (request) -> Observable<(response: HTTPURLResponse, data: Data)> in
                #if DEBUG
                    guard let mockedData = "{\"max\":1.1,\"min\":2.2,\"last\":3.3,\"bid\":4.4,\"ask\":5.5,\"vwap\":6.6,\"average\":7.7,\"volume\":8.8}".data(using: .utf8) else { return Observable.just((response: HTTPURLResponse(), data: Data())) }
                    
                    return Observable.just((response: HTTPURLResponse(), data: mockedData))
                #else
                    return URLSession.shared.rx.response(request: request)
                #endif
            }
            .map { (arguments) -> [String: Any]? in
                let (_, data) = arguments
                return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            }
            .map { (jsonDictionary) -> Ticker? in
                return Ticker(name: tickerName, jsonDictionary: jsonDictionary)
            }
    }
    
}
