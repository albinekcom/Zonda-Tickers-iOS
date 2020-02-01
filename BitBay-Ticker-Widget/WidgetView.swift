import SwiftUI

struct WidgetView : View {
    
    var body: some View {
        Text("This is a SwiftUI view 👋")
    }
    
}

#if DEBUG
struct WidgetView_Previews: PreviewProvider {
    
    static var previews: some View {
        WidgetView()
    }
    
}
#endif
