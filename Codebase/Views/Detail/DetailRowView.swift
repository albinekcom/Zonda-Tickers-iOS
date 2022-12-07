import SwiftUI

struct DetailRowView: View {
    
    let model: Model
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(model.title))
                .font(.callout)
            Spacer()
            Text(model.value)
                .font(.body)
                .foregroundColor(model.valueColor)
        }
        .padding(.vertical)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(LocalizedStringKey(model.title)))
        .accessibilityValue(Text(model.value))
    }
    
}

extension DetailRowView {
    
    struct Model: Identifiable {
        
        let title: String
        let value: String
        let valueColor: Color
        
        init(
            title: String,
            value: String,
            valueColor: Color = .secondary
        ) {
            self.title = title
            self.value = value
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
            value: "1234.567"
        ))
    }
    
}

#endif
