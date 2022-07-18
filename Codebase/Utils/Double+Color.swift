import SwiftUI

extension Double {
    
    var color: Color {
        if self > 0 {
            return .green
        } else if self < 0 {
            return .red
        } else {
            return .orange
        }
    }
    
}
