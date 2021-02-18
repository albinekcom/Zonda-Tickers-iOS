import SwiftUI

struct TickerDetail: View {
    
    let viewModel: TickerDetailViewModel
    
    var body: some View {
        List {
            DetailRow(title: viewModel.title(for: .name), value: viewModel.value(for: .name))
            DetailRow(title: viewModel.title(for: .rate), value: viewModel.value(for: .rate))
            DetailRow(title: viewModel.title(for: .previousRate), value: viewModel.value(for: .previousRate))
            DetailRow(title: viewModel.title(for: .highestRate), value: viewModel.value(for: .highestRate))
            DetailRow(title: viewModel.title(for: .lowestRate), value: viewModel.value(for: .lowestRate))
            DetailRow(title: viewModel.title(for: .highestBid), value: viewModel.value(for: .highestBid))
            DetailRow(title: viewModel.title(for: .lowestAsk), value: viewModel.value(for: .lowestAsk))
            DetailRow(title: viewModel.title(for: .average), value: viewModel.value(for: .average))
            DetailRow(title: viewModel.title(for: .volume), value: viewModel.value(for: .volume))
        }
        .environment(\.defaultMinListRowHeight, 44)
        .navigationBarTitle(viewModel.navigationBarTitle)
        .onAppear {
            let parameters = AnalyticsParametersFactory.makeParameters(from: self.viewModel.model)
            AnalyticsService.shared.trackTickerDetailsView(parameters: parameters)
        }
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
