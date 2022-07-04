import SwiftUI

final class DetailsViewController: UIHostingController<DetailsView> {
    
    init(dataRepository: DataRepository, tickerId: String) {
        super.init(rootView: .init(viewModel: .init(dataRepository: dataRepository, tickerId: tickerId)))
        
        if let ticker = dataRepository.tickers[tickerId] {
            title = "\(ticker.firstCurrency.id.uppercased()) \\ \(ticker.secondCurrency.id.uppercased())"
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
