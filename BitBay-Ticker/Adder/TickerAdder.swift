import SwiftUI

struct TickerAdder: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            TickerAdderContent()
                .environmentObject(userData)
                .navigationBarTitle(Text("Add Ticker"), displayMode: .inline)
                .modifier(AdaptsToSoftwareKeyboard())
        }
        .accentColor(Color.applicationPrimary)
        .onAppear {
            self.userData.isAdding = true
            
            UITableViewCell.appearance().selectionStyle = .none
            
            AnalyticsService.shared.trackAddTickerView()
        }
        .onDisappear {
            self.userData.isAdding = false
        }
    }
}

#if DEBUG
struct TickerAdder_Previews: PreviewProvider {
    
    static var previews: some View {
        TickerAdder(isPresented: .constant(true))
    }
    
}
#endif
