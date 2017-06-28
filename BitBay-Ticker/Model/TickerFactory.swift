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
                return URLSession.shared.rx.response(request: request)
            }
            .map { (_, data) -> [String: Any] in
                guard
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
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
