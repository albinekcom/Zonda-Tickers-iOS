struct TickerIdentifierSorter {
    
    static func sorted(tickerIdentifiers: [TickerIdentifier], sortingOrder: [String]) -> [TickerIdentifier] {
        var sortedTickerIdentifiers = tickerIdentifiers
        
        for sorter in sortingOrder.reversed() {
            sortedTickerIdentifiers.sort {
                $0.secondCurrencyIdentifier.lowercased() == sorter.lowercased() && $1.secondCurrencyIdentifier.lowercased() != sorter.lowercased()
            }
        }
        
        return sortedTickerIdentifiers
    }
    
}
