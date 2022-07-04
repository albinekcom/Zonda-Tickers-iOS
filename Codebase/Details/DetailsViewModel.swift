import Combine

final class DetailsViewModel: ObservableObject {
    
    @Published private(set) var detailsRowViewModels: [DetailsRowViewModel] = []
    
    let tickerId: String
    
    init(dataRepository: DataRepository, tickerId: String) {
        self.tickerId = tickerId
        
        dataRepository.$tickers
            .compactMap { $0[tickerId]?.detailsRowViewModels }
            .assign(to: &$detailsRowViewModels)
    }
    
}

private extension Ticker {
    
    var detailsRowViewModels: [DetailsRowViewModel] {
        [.init(title: "Name",
               valueString: firstCurrency.name ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Rate",
               valueString: rate?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Change",
               valueString: change?.pretty(precision: secondCurrency.precision, positivePrefix: "+") ?? "-",
               valueStringColorStyle: change.stringColorStyle),
         .init(title: "Change (%)",
               valueString: changeRatio?.pretty(precision: 2, numberStyle: .percent, positivePrefix: "+") ?? "-",
               valueStringColorStyle: changeRatio.stringColorStyle),
         .init(title: "Previous rate",
               valueString: previousRate?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Highest rate",
               valueString: highestRate?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Lowest rate",
               valueString: lowestRate?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Bid",
               valueString: highestBid?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Ask",
               valueString: lowestAsk?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Average",
               valueString: average?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Volume",
               valueString: volume?.pretty(precision: nil) ?? "-",
               valueStringColorStyle: .normal),
         .init(title: "Volume value",
               valueString: volumeValue?.pretty(precision: secondCurrency.precision) ?? "-",
               valueStringColorStyle: .normal)]
    }
    
}
