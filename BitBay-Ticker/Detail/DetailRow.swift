import SwiftUI

struct DetailRow: View {
    
    let title: Text
    let value: String
    
    var body: some View {
        HStack {
            title
            Spacer()
            Text(value)
        }.padding()
    }
    
}

#if DEBUG
struct DetailRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let title = Text("Test Title")
        let value = "Some Value"
        
        return Group {
            DetailRow(title: title, value: value)
            DetailRow(title: title, value: value)
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
    
}
#endif
