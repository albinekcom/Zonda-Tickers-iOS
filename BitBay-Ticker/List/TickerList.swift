import SwiftUI

struct TickerList: View {
    
    @EnvironmentObject private var userData: UserData
    @State private var isPresentingTickerAdder = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.tickers) { ticker in
                    NavigationLink(
                        destination: TickerDetail(viewModel: TickerDetailViewModel(model: ticker))
                    ) {
                        BasicRow(title: Text(ticker.title), value: PrettyValueFormatter.makePrettyString(value: ticker.rate, scale: ticker.secondCurrency?.scale, currency: ticker.secondCurrency?.currency))
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
                        self.userData.refreshAllAvailableTickersIdentifiersToAdd()
                        self.isPresentingTickerAdder.toggle()
                    }) {
                        Image(systemName: "plus.circle") // TODO: Increase tapping area
                    }.sheet(isPresented: $isPresentingTickerAdder) {
                        TickerAdder(isPresented: self.$isPresentingTickerAdder).environmentObject(self.userData)
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
