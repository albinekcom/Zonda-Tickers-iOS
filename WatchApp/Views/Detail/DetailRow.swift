import SwiftUI

struct DetailRow: View {
    
    let model: Model
    
    var body: some View {
        HStack {
            Text(model.title)
                .font(.callout)
            Spacer()
            Text(model.value)
                .font(.body)
                .foregroundColor(model.valueColor)
        }
        .padding(.vertical)
        .animation(.default, value: model.value)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(model.title))
        .accessibilityValue(Text(model.value))
    }
    
}

extension DetailRow {
    
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
        DetailRow(model: .init(
            title: "Title",
            value: "Value",
            valueColor: .red
        ))
    }
    
}

#endif
