import SwiftUI

struct AccessoryRectangularRow: View {
    
    let model: Model
    
    var body: some View {
        HStack {
            Label(
                model.title,
                systemImage: model.icon.rawValue
            ).labelStyle(AccessoryRectangularTickerRowLabelStyle())
            Spacer()
            Text(model.valueText)
        }
    }
    
}

private struct AccessoryRectangularTickerRowLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 2) {
            configuration.icon
            configuration.title
        }
    }
    
}

extension AccessoryRectangularRow {
    
    struct Model {
        
        let icon: Image.SystemName
        let title: String
        let valueText: String
        
    }
    
}
