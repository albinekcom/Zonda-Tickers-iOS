import Foundation
import RxDataSources

struct SectionOfTickerViewModel {
    
    var items: [Item]
    
}

extension SectionOfTickerViewModel: SectionModelType {
    
    typealias Item = TickerViewModel
    
    init(original: SectionOfTickerViewModel, items: [Item]) {
        self = original
        
        self.items = items
    }
    
}
