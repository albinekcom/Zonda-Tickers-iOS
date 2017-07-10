import Foundation
import RxSwift

final class TickerStore {
    
    static let shared = TickerStore()
    
    private let disposeBag = DisposeBag()
    
    var userTickers = Variable<[Ticker]>([])
    
    var lastUpdateDate = Variable<Date?>(nil)
    
    private let allAvailableTickersNames: [Ticker.Name] = [
        .btcpln, .ethpln, .ltcpln, .lskpln,
        .btceur, .etheur, .ltceur, .lskeur,
        .btcusd, .ethusd, .ltcusd, .lskusd,
        .ltcbtc, .ethbtc, .lskbtc
    ]
    
    private let defaultTickersNames: [Ticker.Name] = [
        .btcpln, .ethpln, .ltcpln, .lskpln
    ]
    
    func refreshTickers(completion: ((Error?) -> Void)?) {
        Observable
            .zip(
                userTickers.value.map { (ticker) in
                    return TickerFactory.makeObservableTicker(named: ticker.name)
                }
            )
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (tickers) in
                    self?.userTickers.value = tickers
                    completion?(nil)
                },
                onError: { (error) in
                    completion?(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    var availableTickersNamesToAdd: [Ticker.Name] {
        let userTickerNames = userTickers.value.map {
            return $0.name
        }
        
        let duplicates = allAvailableTickersNames.filter(userTickerNames.contains)
        
        return allAvailableTickersNames.filter {
            return !duplicates.contains($0)
        }
    }
    
    func addTicker(named tickerName: Ticker.Name) {
        let ticker = Ticker(name: tickerName, jsonDictionary: nil)
        
        userTickers.value.append(ticker)
        
        refreshTickers(completion: nil)
    }
    
    // MARK: - User Data
    
    private let userDataPlistName = "user_data"
    
    private var userDataDictionary: [String: Any] {
        let allUserTickersDictionary = userTickers.value.map {
            return $0.dictionary
        }
        
        var userDataDictionary = [String: Any]()
        
        userDataDictionary["tickers"] = allUserTickersDictionary
        
        if let lastUpdateDate = lastUpdateDate.value {
            userDataDictionary["lastUpdateTimeIntervalSinceReferenceDate"] = lastUpdateDate.timeIntervalSinceReferenceDate
        }
        
        return userDataDictionary
    }
    
    // MARK: - Loading
    
    func loadUserData() {
        if PlistFile(name: userDataPlistName).isUserDataCreated {
            loadUserDataFromFile()
        } else {
            userTickers.value = defaultTickersNames.map { (tickerName) in
                return Ticker(name: tickerName, jsonDictionary: nil)
            }
        }
    }
    
    private func loadUserDataFromFile() {
        let loadedUserDataDictionary = PlistFile(name: userDataPlistName).dictionary
        
        if let lastUpdateTimeIntervalSinceReferenceDate = loadedUserDataDictionary?["lastUpdateTimeIntervalSinceReferenceDate"] as? TimeInterval {
            lastUpdateDate.value = Date(timeIntervalSinceReferenceDate: lastUpdateTimeIntervalSinceReferenceDate)
        }
        
        guard let allTickers = loadedUserDataDictionary?["tickers"] as? [[String: Any]] else { return }
        
        var loadedTickers = [Ticker]()
        
        allTickers.forEach {
            let loadedTicker = Ticker(fromDictionary: $0)
            loadedTickers.append(loadedTicker)
        }
        
        userTickers.value = loadedTickers
    }
    
    // MARK: - Saving
    
    func saveUserData() {
        _ = PlistFile(name: userDataPlistName).save(dictionary: userDataDictionary)
    }

}
