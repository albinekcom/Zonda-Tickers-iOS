struct TickerIdentifier: Codable, Equatable, Identifiable {
    
    let id: String
    
    var title: String {
        "\(firstCurrencyIdentifier)/\(secondCurrencyIdentifier)"
    }
    
    var firstCurrencyIdentifier: String {
        currencyIdentifier.first ?? ""
    }
    
    var secondCurrencyIdentifier: String {
        currencyIdentifier.last ?? ""
    }
    
    private var currencyIdentifier: [String] {
        id.components(separatedBy: "-")
    }
}
