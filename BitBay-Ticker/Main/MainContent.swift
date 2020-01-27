import SwiftUI

struct MainContent: View {
    
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        VStack {
            if userData.areTickersLoaded == false {
                EmptyView()
            } else if userData.tickers.isEmpty {
                TickerEmptyList()
            } else {
                TickerList().environmentObject(userData)
            }
        }
    }
    
}

#if DEBUG
struct MainContent_Previews: PreviewProvider {
    
    static var previews: some View {
        MainContent()
    }
    
}
#endif
