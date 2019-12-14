import SwiftUI

struct TickerDetail: View {
    
    @EnvironmentObject var userData: UserData
    let ticker: Ticker
    
    var body: some View {
        List {
            DetailRow(title: Text("ticker.details.last"), value: "\(ticker.rate ?? 0)")
            DetailRow(title: Text("ticker.details.max"), value: "\(ticker.highestRate ?? 0)")
            DetailRow(title: Text("ticker.details.min"), value: "\(ticker.lowestRate ?? 0)")
            DetailRow(title: Text("ticker.details.bid"), value: "\(ticker.highestBid ?? 0)")
            DetailRow(title: Text("ticker.details.ask"), value: "\(ticker.lowestAsk ?? 0)")
            DetailRow(title: Text("ticker.details.average"), value: "\(ticker.average ?? 0)")
            DetailRow(title: Text("ticker.details.volume"), value: "\(ticker.volume ?? 0)")
        }
        .navigationBarTitle(Text(ticker.title))
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
