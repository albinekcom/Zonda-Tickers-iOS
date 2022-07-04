struct TickerRowViewModel: Identifiable {
    
    var id: String { ticker.id }
    
    var firstCurrencyId: String { ticker.firstCurrency.id.uppercased() }
    var secondCurrencyId: String { ticker.secondCurrency.id.uppercased() }
    
    var rateString: String { ticker.rate?.pretty(precision: ticker.secondCurrency.precision) ?? "-" }
    
    var trendIconStyle: TrendIconStyle { ticker.changeRatio.trendIconStyle }
    
    var changeRatioString: String {
        ticker.changeRatio?.pretty(
            precision: 2,
            numberStyle: .percent,
            positivePrefix: "",
            negativePrefix: ""
        ) ?? ""
    }
    
    var changeRatioStringColorStyle: StringColorStyle { ticker.changeRatio.stringColorStyle }
    
    var tags: [String] {
        [ticker.id,
         ticker.firstCurrency.id,
         ticker.secondCurrency.id,
         ticker.firstCurrency.id,
         "\(ticker.firstCurrency.id)\(ticker.secondCurrency.id)",
         "\(ticker.firstCurrency.id)\\\(ticker.secondCurrency.id)",
         ticker.firstCurrency.name?.lowercased(),
         ticker.secondCurrency.name?.lowercased()
        ].compactMap { $0 }
    }
    
    private let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
    }
    
}

extension TickerRowViewModel: Comparable {
    
    static func <(lhs: TickerRowViewModel, rhs: TickerRowViewModel) -> Bool {
        lhs.secondCurrencyId == rhs.secondCurrencyId ? lhs.firstCurrencyId < rhs.firstCurrencyId : lhs.secondCurrencyId < rhs.secondCurrencyId
    }
    
}

private extension Optional where Wrapped == Double {
    
    var trendIconStyle: TrendIconStyle {
        guard let self = self, self != 0 else { return .neutral }
        
        return self > 0 ? .up : .down
    }
    
}
