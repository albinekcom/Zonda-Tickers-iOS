import SwiftUI

struct EmptyDetailsView: View {
    
    var body: some View {
        Text("Select ticker")
    }
    
}

#if DEBUG

struct EmptyDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmptyDetailsView()
    }
    
}

#endif
