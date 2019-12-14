import SwiftUI

struct BasicRow: View {
    
    let title: Text
    let value: String
    
    var body: some View {
        HStack {
            title
            Spacer()
            Text(value)
        }
    }
    
}

#if DEBUG
struct BaiscRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let title = Text("Test Title")
        let value = "$ Some Value"
        
        return Group {
            BasicRow(title: title, value: value)
            BasicRow(title: title, value: value)
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
    
}
#endif
