import Foundation
import RxDataSources

struct SectionOfTickerViewModel {
    
    var items: [TickerViewModel]
    
}

extension SectionOfTickerViewModel: AnimatableSectionModelType {
    
    typealias Item = TickerViewModel
    
    typealias Identity = String
    
    var identity: String {
        return "Main Section"
    }
        
    init(original: SectionOfTickerViewModel, items: [TickerViewModel]) {
        self = original
        self.items = items
    }
    
}

extension SectionOfTickerViewModel: Equatable { }

func == (lhs: SectionOfTickerViewModel, rhs: SectionOfTickerViewModel) -> Bool {
    return lhs.identity == rhs.identity
}

