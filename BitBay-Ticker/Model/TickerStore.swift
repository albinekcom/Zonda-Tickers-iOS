import Foundation
import RxSwift

final class TickerStore {
    
    var tickers = Variable<[Ticker]>([])
    
    let allAvailableTickersNames: [Ticker.Name] = [
        .btcpln, .ethpln, .ltcpln, .lskpln,
        .btceur, .etheur, .ltceur, .lskeur,
        .btcusd, .ethusd, .ltcusd, .lskusd,
        .ltcbtc, .ethbtc, .lskbtc
    ]
    
    var availableTickersToAdd: [Ticker.Name] = []

}
