import SwiftUI

struct TickerDetail: View {
    
    let viewModel: TickerDetailViewModel
    
    var body: some View {
        List {
            BasicRow(title: viewModel.title(for: .rate), value: viewModel.value(for: .rate))
            BasicRow(title: viewModel.title(for: .highestRate), value: viewModel.value(for: .highestRate))
            BasicRow(title: viewModel.title(for: .lowestRate), value: viewModel.value(for: .lowestRate))
            BasicRow(title: viewModel.title(for: .highestBid), value: viewModel.value(for: .highestBid))
            BasicRow(title: viewModel.title(for: .lowestAsk), value: viewModel.value(for: .lowestAsk))
            BasicRow(title: viewModel.title(for: .average), value: viewModel.value(for: .average))
            BasicRow(title: viewModel.title(for: .volume), value: viewModel.value(for: .volume))
        }
        .navigationBarTitle(viewModel.navigationBarTitle)
    }
    
}

#if DEBUG
struct TickerDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        let userData = UserData()
        
        return TickerDetail(viewModel: TickerDetailViewModel(model: userData.tickers[0]))
            .environmentObject(userData)
            .environment(\.locale, .init(identifier: "en"))
    }
    
}
#endif
