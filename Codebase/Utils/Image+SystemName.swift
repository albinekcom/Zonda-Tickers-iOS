import SwiftUI

extension Image {
    
    enum SystemName: String {
        
        case multiplyCircleFill = "multiply.circle.fill"
        case plus
        case plusCircleFill = "plus.circle.fill"
        case xmarkOctagonFill = "xmark.octagon.fill"
        
    }
    
    init(systemName: SystemName) {
        self.init(systemName: systemName.rawValue)
    }
    
}
