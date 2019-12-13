import UIKit

struct TickerIdentifier: Hashable, Codable, Identifiable {
    
    let id: String
    
    var firstCurrencyIdentifier: String? {
        id.components(separatedBy: "-").first
    }
    
    var secondCurrencyIdentifier: String? {
        id.components(separatedBy: "-").last
    }
}
