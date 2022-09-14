import SwiftUI

struct DetailRow: View {
    
    let title: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.callout)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(valueColor)
        }
        .padding(.vertical)
        .animation(.default, value: value)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(title))
        .accessibilityValue(Text(value))
    }
    
}

#if DEBUG

struct DetailRow_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailRow(
            title: "Title",
            value: "1234.567",
            valueColor: .secondary
        )
    }
    
}

#endif
