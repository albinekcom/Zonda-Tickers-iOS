import SwiftUI

struct Main: View {
    
    @EnvironmentObject private var userData: UserData
    @State private var isPresentingTickerAdder = false
    
    var body: some View {
        NavigationView {
            MainContent().environmentObject(self.userData)
                .navigationBarTitle(Text("Tickers"))
                .navigationBarItems(
                    leading:
                        Button(action: {
                            self.userData.refreshAllAvailableTickersIdentifiersToAdd()
                            self.isPresentingTickerAdder.toggle()
                        }) {
                            AdderButtonView()
                        }
                        .frame(minWidth: MimiumTouchTargetSize.size, minHeight: MimiumTouchTargetSize.size)
                        .sheet(isPresented: $isPresentingTickerAdder) {
                            TickerAdder(isPresented: self.$isPresentingTickerAdder).environmentObject(self.userData)
                        },
                    trailing:
                        VStack {
                            if userData.tickers.count > 0 {
                                EditButton()
                                    .frame(minWidth: MimiumTouchTargetSize.size, minHeight: MimiumTouchTargetSize.size)
                            }
                            
                        }
                        
                )
        }
        .onAppear {
            AnalyticsService.shared.trackTickersView()
            
//            ReviewPopUpController().displayReviewPopUpIfNeeded() // TODO: Uncomment this line before releasing
        }
        .accentColor(Color.applicationPrimary)
    }
    
}

#if DEBUG
struct Main_Previews: PreviewProvider {
    
    static var previews: some View {
        Main()
    }
    
}
#endif
