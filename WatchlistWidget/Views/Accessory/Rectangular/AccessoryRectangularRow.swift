import SwiftUI

struct AccessoryRectangularRow: View {
    
    let model: Model
    
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: model.icon)
                    .rotationEffect(.radians(model.isGain ? 0 : .pi))
                Text(model.title)
            }
            
            Spacer()
            
            Text(model.valueText)
        }
    }
    
}

extension AccessoryRectangularRow {
    
    struct Model {
        
        let icon: Image.SystemName
        let title: String
        let valueText: String
        let isGain: Bool
        
    }
    
}
