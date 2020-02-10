import SwiftUI

struct Main: View {
    
    @EnvironmentObject private var userData: UserData
    @State private var isPresentingTickerAdder: Bool = false
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        self.userData.isEditing = editMode.isEditing // HACK
        
        return NavigationView {
            MainContent().environmentObject(self.userData)
                .navigationBarTitle(Text("Tickers"))
                .navigationBarItems(
                    leading:
                        Button(action: {
                            self.userData.refreshTickersIdentifiers()
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
                .environment(\.editMode, self.$editMode)
        }
        .onAppear {
            AnalyticsService.shared.trackTickersView()
            
            ReviewPopUpController().displayReviewPopUpIfNeeded()
        }
        .accentColor(Color.applicationPrimary)
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .padding(.leading, 1) // HACK for iPad, link: https://stackoverflow.com/a/58371424
    }
    
}

#if DEBUG
struct Main_Previews: PreviewProvider {
    
    static var previews: some View {
        Main()
    }
    
}
#endif
