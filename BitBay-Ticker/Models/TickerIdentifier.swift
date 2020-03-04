struct TickerIdentifier: Codable, Identifiable {
    
    let id: String
    
    var firstCurrencyName: String?
    var secondCurrencyName: String?
    
}

extension TickerIdentifier {
    
    var firstCurrencyIdentifier: String {
        currencyIdentifier.first ?? ""
    }
    
    var secondCurrencyIdentifier: String {
        currencyIdentifier.last ?? ""
    }
    
    var prettyTitle: String {
        "\(firstCurrencyIdentifier)\\\(secondCurrencyIdentifier)"
    }
    
    func tagsContain(searchTerm: String) -> Bool {
        for tag in tags {
            if tag.localizedCaseInsensitiveContains(searchTerm) {
                return true
            }
        }
        
        return false
    }
    
    private var currencyIdentifier: [String] {
        id.components(separatedBy: "-")
    }
    
    private var tags: [String] {
        var tags: [String] = []
        
        tags.append("\(firstCurrencyIdentifier)\\\(secondCurrencyIdentifier)")
        tags.append("\(firstCurrencyIdentifier)\(secondCurrencyIdentifier)")
        tags.append("\(firstCurrencyIdentifier)-\(secondCurrencyIdentifier)")
        tags.append("\(firstCurrencyIdentifier)/\(secondCurrencyIdentifier)")
        
        if let firstCurrencyName = firstCurrencyName {
            tags.append(firstCurrencyName)
        }
        
        if let secondCurrencyName = secondCurrencyName {
            tags.append(secondCurrencyName)
        }
        
        return tags
    }
    
}

extension TickerIdentifier: Equatable {
    
    static func == (lhs: TickerIdentifier, rhs: TickerIdentifier) -> Bool {
        lhs.id == rhs.id
    }
    
}
