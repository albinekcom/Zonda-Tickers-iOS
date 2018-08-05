import Foundation
import RxSwift

final class TickerStore {
    
    struct Key {
        static let tickers = "tickers"
        static let lastUpdateTimeIntervalSinceReferenceDate = "lastUpdateTimeIntervalSinceReferenceDate"
    }
    
    enum RefreshingType: String {
        case user = "User"
        case automatic = "Automatic"
        case widget = "Widget"
    }
    
    static let shared = TickerStore()
    
    private let disposeBag = DisposeBag()
    
    var userTickers = Variable<[Ticker]>([])
    
    var lastUpdateDate = Variable<Date?>(nil)
    
    let refreshingSubject = PublishSubject<Bool>()
    
    private let allAvailableTickersNames: [Ticker.Name] = [
        .btcpln, .ethpln, .ltcpln, .lskpln, .bccpln, .dashpln, .gamepln, .btgpln, .kzcpln, .xrppln, .xinpln, .xmrpln, .zecpln, .gntpln, .omgpln, .ftopln, .reppln, .batpln, .zrxpln, .paypln,
        .btceur, .etheur, .ltceur, .lskeur, .bcceur, .dasheur, .gameeur, .btgeur, .kzceur, .xrpeur, .xineur, .xmreur, .zeceur, .gnteur, .omgeur, .ftoeur, .repeur, .batpln, .zrxpln, .paypln,
        .btcusd, .ethusd, .ltcusd, .lskusd, .bccusd, .dashusd, .gameusd, .btgusd, .kzcusd, .xrpusd, .xinusd, .xmrusd, .zecusd, .gntusd, .omgusd, .ftousd, .repusd, .batusd, .zrxusd, .payusd,
                 .ethbtc, .ltcbtc, .lskbtc, .bccbtc, .dashbtc, .gamebtc, .btgbtc, .kzcbtc, .xrpbtc, .xinbtc, .xmrbtc, .zecbtc, .gntbtc, .omgbtc, .ftobtc, .repbtc, .batbtc, .zrxbtc, .paybtc
    ]
    
    private let defaultTickersNames: [Ticker.Name] = [
        .btcpln, .ethpln, .ltcpln, .lskpln, .bccpln, .dashpln, .gamepln, .btgpln, .kzcpln, .xrppln, .xinpln, .xmrpln, .zecpln, .gntpln, .omgpln, .ftopln, .reppln, .batpln, .zrxpln, .paypln
    ]
    
    func refreshTickers(refreshingType: RefreshingType, completion: ((Error?) -> Void)? = nil) {
        Observable
            .zip(
                userTickers.value.map { (ticker) in
                    return TickerFactory.makeObservableTicker(named: ticker.name)
                }
            )
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] (tickers) in
                    let tickers = tickers.compactMap { $0 }
                    self?.userTickers.value = tickers
                    self?.refreshingSubject.on(.next(true))
                    
                    let tickersAnalyticsParameters = AnalyticsParametersFactory.makeParameters(from: tickers)
                    let refreshingTypeAnalyticsParameters = AnalyticsParametersFactory.makeParameters(from: refreshingType)
                    let analyticsParameters = tickersAnalyticsParameters.merged(with: refreshingTypeAnalyticsParameters)
                    
                    AnalyticsService.trackRefreshedTickers(parameters: analyticsParameters)
                    
                    completion?(nil)
                },
                onError: { [weak self] (error) in
                    self?.refreshingSubject.on(.next(false))
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
    
    func swap(sourceRow: Int, destinationRow: Int) {
        let movedTicker = userTickers.value.remove(at: sourceRow)
        userTickers.value.insert(movedTicker, at: destinationRow)
    }
    
    func removeTicker(at row: Int) {
        let removedTicker = userTickers.value.remove(at: row)
        
        let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: removedTicker)
        AnalyticsService.trackRemovedTicker(parameters: analyticsParameters)
    }
    
    func addTicker(named tickerName: Ticker.Name) {
        if let ticker = Ticker(name: tickerName, jsonDictionary: nil) {
            userTickers.value.append(ticker)
            
            let analyticsParameters = AnalyticsParametersFactory.makeParameters(from: ticker)
            AnalyticsService.trackAddedTicker(parameters: analyticsParameters)
        }
        
        refreshTickers(refreshingType: .automatic)
    }
    
    // MARK: - User Data
    
    static let userDataPlistName = "user_data"
    static let sharedDefaultsIdentifier = "group.com.albinek.ios.BitBay-Ticker.shared.defaults"
    
    private var userDataDictionary: [String: Any] {
        let allUserTickersDictionary = userTickers.value.map {
            return $0.dictionary
        }
        
        var userDataDictionary = [String: Any]()
        
        userDataDictionary[Key.tickers] = allUserTickersDictionary
        
        if let lastUpdateDate = lastUpdateDate.value {
            userDataDictionary[Key.lastUpdateTimeIntervalSinceReferenceDate] = lastUpdateDate.timeIntervalSinceReferenceDate
        }
        
        return userDataDictionary
    }
    
    // MARK: - Loading
    
    func loadUserData() {
        if let sharedUserDefaults = UserDefaults(suiteName: TickerStore.sharedDefaultsIdentifier), let data = sharedUserDefaults.value(forKey: TickerStore.userDataPlistName) as? Data, let values = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any] {
            loadUserData(from: values)
        } else {
            userTickers.value =
                defaultTickersNames
                    .map { (tickerName) in
                        return Ticker(name: tickerName, jsonDictionary: nil)
                    }
                    .compactMap { return $0 }
        }
    }
    
    private func loadUserData(from dictionary: [String: Any]) {
        if let lastUpdateTimeIntervalSinceReferenceDate = dictionary[Key.lastUpdateTimeIntervalSinceReferenceDate] as? TimeInterval {
            lastUpdateDate.value = Date(timeIntervalSinceReferenceDate: lastUpdateTimeIntervalSinceReferenceDate)
        }
        
        guard let allTickers = dictionary[Key.tickers] as? [[String: Any]] else { return }
        
        var loadedTickers = [Ticker]()
        
        allTickers.forEach {
            if let loadedTicker = Ticker(fromDictionary: $0) {
                loadedTickers.append(loadedTicker)
            }
        }
        
        userTickers.value = loadedTickers
    }
    
    // MARK: - Saving
    
    func saveUserData() {
        let sharedUserDefaults = UserDefaults(suiteName: TickerStore.sharedDefaultsIdentifier)
        
        let encodedUserDataDictionary = NSKeyedArchiver.archivedData(withRootObject: userDataDictionary)
        sharedUserDefaults?.set(encodedUserDataDictionary, forKey: TickerStore.userDataPlistName)
        sharedUserDefaults?.synchronize()
    }
    
}
