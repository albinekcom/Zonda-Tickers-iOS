import SwiftUI

extension Image {
    
    enum SystemName: String {
        
        case magnifyingGlass = "magnifyingglass"
        case multiplyCircleFill = "multiply.circle.fill"
        case plusCircleFill = "plus.circle.fill"
        case xmarkOctagonFill = "xmark.octagon.fill"
        
    }
    
    init(systemName: SystemName) {
        self.init(systemName: systemName.rawValue)
    }
    
}
