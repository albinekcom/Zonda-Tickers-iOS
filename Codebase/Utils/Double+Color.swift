import SwiftUI

extension Double {
    
    var color: Color {
        let color: Color
        
        if self > 0 {
            color = .green
        } else if self < 0 {
            color = .red
        } else {
            color = .orange
        }
        
        return color
    }
    
}
