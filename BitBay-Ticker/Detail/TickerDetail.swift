import SwiftUI

struct TickerDetail: View {
    
    @EnvironmentObject var userData: UserData
    let ticker: Ticker
    
    var body: some View {
        List {
            DetailRow(title: Text("ticker.details.last"), value: "Value 1") // TODO: Use a correct property here
            DetailRow(title: Text("ticker.details.max"), value: "Value 2") // TODO: Use a correct property here
            DetailRow(title: Text("ticker.details.min"), value: "Value 3") // TODO: Use a correct property here
            DetailRow(title: Text("ticker.details.bid"), value: "\(ticker.highestBid)") // TODO: Verify displaying this value
            DetailRow(title: Text("ticker.details.ask"), value: "\(ticker.lowestAsk)") // TODO: Verify displaying this value
            DetailRow(title: Text("ticker.details.vwap"), value: "Value 6") // TODO: Use a correct property here
            DetailRow(title: Text("ticker.details.average"), value: "Value 7") // TODO: Use a correct property here
            DetailRow(title: Text("ticker.details.volume"), value: "Value 8") // TODO: Use a correct property here
        }
        .navigationBarTitle(Text(ticker.id)) // TODO: Use a correct property here
    }
    
}

#if DEBUG
struct TickerDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        let userData = UserData()
        
        return TickerDetail(ticker: userData.tickers[0])
            .environmentObject(userData)
            .environment(\.locale, .init(identifier: "en"))
    }
    
}
#endif
