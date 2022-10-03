import SwiftUI

extension Image {
    
    enum SystemName: String {
        
        case arrowTriangleUpFill = "arrowtriangle.up.fill"
        case multiplyCircleFill = "multiply.circle.fill"
        case plus
        case plusCircleFill = "plus.circle.fill"
        case squareFill = "square.fill"
        case xmarkOctagonFill = "xmark.octagon.fill"
        
    }
    
    init(systemName: SystemName) {
        self.init(systemName: systemName.rawValue)
    }
    
}
