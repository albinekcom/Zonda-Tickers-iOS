import SwiftUI

struct TickerList: View {
    
    @EnvironmentObject private var userData: UserData
    @State var isPresentingTickerAdderView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.tickers) { ticker in
                    NavigationLink(
                        destination: TickerDetail(ticker: ticker).environmentObject(self.userData)
                    ) {
                        TickerRow(ticker: ticker)
                            .padding(.top)
                            .padding(.bottom)
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .navigationBarTitle(Text("tickers.title"))
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.isPresentingTickerAdderView = true
                    }) {
                        Image(systemName: "plus.circle")
                    }.sheet(isPresented: $isPresentingTickerAdderView) {
                        TickerAdder().environmentObject(self.userData)
                    },
                trailing: EditButton()
            )
        }
    }
    
    private func delete(at offsets: IndexSet) {
        userData.tickers.remove(atOffsets: offsets)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        userData.tickers.move(fromOffsets: source, toOffset: destination)
    }
    
}

#if DEBUG
struct TickerList_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(["iPhone 11 Pro"], id: \.self) { deviceName in
            TickerList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
        .environment(\.colorScheme, .dark)
    }
    
}
#endif
