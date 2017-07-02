import Foundation
import RxSwift

final class TickerStore {
    
    private let disposeBag = DisposeBag()
    
    var tickers = Variable<[Ticker]>([])
    
    private let allAvailableTickersNames: [Ticker.Name] = [
        .btcpln, .ethpln, .ltcpln, .lskpln,
        .btceur, .etheur, .ltceur, .lskeur,
        .btcusd, .ethusd, .ltcusd, .lskusd,
        .ltcbtc, .ethbtc, .lskbtc
    ]
    
    var availableTickersToAdd: [Ticker.Name] = []
    
    func refreshTickers() {
        Observable
            .zip(
                allAvailableTickersNames.map { (tickerName) in
                    return TickerFactory.makeObservableTicker(named: tickerName)
                }
            )
            .subscribe(
                onNext: { [weak self] (tickers) in
                    self?.tickers.value = tickers
                }
            )
            .disposed(by: disposeBag)
    }

}
