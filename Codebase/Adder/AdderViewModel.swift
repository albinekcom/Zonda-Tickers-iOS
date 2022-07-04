import Combine

final class AdderViewModel: ObservableObject {
    
    @Published private(set) var tickerRowViewModels: [TickerRowViewModel]?
    @Published var searchString = ""
    
    private let dataRepository: DataRepository
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
        
        Publishers
            .CombineLatest3(dataRepository.$tickers, dataRepository.$userTickerIds, $searchString)
            .compactMap { $0.0.tickerRowViewModels(userTickerIds: $0.1, searchString: $0.2) }
            .assign(to: &$tickerRowViewModels)
    }
    
    func appendUserTickerId(_ tickerId: String) {
        dataRepository.userTickerIds.append(tickerId)
        
        AnalyticsService.shared.trackUserTickerAppended(tickerId: tickerId)
    }
    
}

private extension Array where Element == Ticker {
    
    func tickerRowViewModels(userTickerIds: [String], searchString: String) -> [TickerRowViewModel] {
        filter { userTickerIds.contains($0.id) == false }
            .map { TickerRowViewModel(ticker: $0) }
            .filter {
                (searchString.isEmpty || $0.tags.joined(separator: " ").contains(searchString.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()))
            }
    }
    
}
