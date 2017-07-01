import Foundation
import RxDataSources
import RxCocoa
import RxSwift

struct TickerViewModel {
    
    let model: Ticker
    
    var name: String {
        return "\(model.baseCurrency)/\(model.counterCurrency)"
    }
    
    var last: String {
        let lastValueString: String
        
        if let last = model.last {
            lastValueString = "\(last)"
        } else {
            lastValueString = "-"
        }
        
        return "\(lastValueString) \(model.counterCurrency)"
    }
    
}
