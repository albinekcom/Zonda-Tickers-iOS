import SwiftUI

struct DetailRow: View {
    
    let title: Text
    let value: String
    
    var body: some View {
        HStack {
            title
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .accessibility(label: title)
        .accessibility(value: Text(value))
    }
    
}

#if DEBUG
struct DetailRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let title = Text("Test Title")
        let value = "$ 123.45"
        
        return Group {
            DetailRow(title: title, value: value)
                .previewLayout(.fixed(width: 400, height: 70))
                .environment(\.colorScheme, .light)
            DetailRow(title: title, value: value)
                .previewLayout(.fixed(width: 400, height: 70))
                .environment(\.colorScheme, .dark)
        }
    }
    
}
#endif
