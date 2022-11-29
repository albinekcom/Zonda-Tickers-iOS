import SwiftUI

struct AccessoryRectangularRow: View {
    
    let model: Model
    
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: model.icon)
                    .rotationEffect(.radians(model.isGain ? 0 : .pi))
                    .foregroundColor(model.valueColor)
                Text(model.title)
            }
            
            Spacer()
            
            Text(model.valueText)
                .foregroundColor(model.valueColor)
        }
    }
    
}

extension AccessoryRectangularRow {
    
    struct Model {
        
        let icon: Image.SystemName
        let title: String
        let valueText: String
        let valueColor: Color
        let isGain: Bool
        
    }
    
}
