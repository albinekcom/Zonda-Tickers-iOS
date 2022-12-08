import SwiftUI

struct DetailRowView: View {
    
    let model: Model
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(model.title))
                .font(.callout)
            Spacer()
            Text(model.valueText)
                .font(.body)
                .foregroundColor(model.valueColor)
        }
        .padding(.vertical)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(LocalizedStringKey(model.title)))
        .accessibilityValue(Text(model.valueText))
    }
    
}

extension DetailRowView {
    
    struct Model: Identifiable, Equatable {
        
        let title: String
        let valueText: String
        let valueColor: Color
        
        init(
            title: String,
            valueText: String,
            valueColor: Color = .secondary
        ) {
            self.title = title
            self.valueText = valueText
            self.valueColor = valueColor
        }
        
        var id: String { title }
        
    }
    
}

#if DEBUG && !TESTING

struct DetailRow_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailRowView(model: .init(
            title: "Title",
            valueText: "1234.567"
        ))
    }
    
}

#endif
