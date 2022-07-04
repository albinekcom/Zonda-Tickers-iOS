import SwiftUI

enum StringColorStyle {
    
    case negative
    case neutral
    case normal
    case positive
    
}

extension StringColorStyle {
    
    var color: Color {
        switch self {
        case .negative: return .red
        case .neutral: return .orange
        case .normal: return .secondary
        case .positive: return .green
        }
    }
    
}
