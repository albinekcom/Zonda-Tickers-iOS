struct TickerIdentifier: Codable, Identifiable {
    
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
    
    var firstCurrencyFullName: String?
    var secondCurrencyFullName: String?
    
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
        var tags: [String] = [title]
        
        if let firstCurrencyFullName = firstCurrencyFullName {
            tags.append(firstCurrencyFullName)
        }
        
        if let secondCurrencyFullName = secondCurrencyFullName {
            tags.append(secondCurrencyFullName)
        }
        
        return tags
    }
}

extension TickerIdentifier: Equatable {
    
    static func == (lhs: TickerIdentifier, rhs: TickerIdentifier) -> Bool {
        return lhs.id == rhs.id
    }
    
}
