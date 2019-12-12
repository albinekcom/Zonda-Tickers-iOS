import SwiftUI

struct ListView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Hello, List!")
            Text("Hello, List!")
        }
    }
    
}

#if DEBUG
struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
           ListView()
              .environment(\.colorScheme, .light)
        }
    }
    
}
#endif
