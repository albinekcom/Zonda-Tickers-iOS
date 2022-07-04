import Foundation

final class OldLocalDataRepositoryMigrator {
    
    private let oldUserDataTickersObjectName = "user_data_tickers_v1"
    
    var userTickerIds: [String]? {
        let migratedUserTickerIds = oldTickersFromFile?.compactMap { $0.id.lowercased() }
        
        UserDefaults.oldShared?.removeObject(forKey: oldUserDataTickersObjectName)
        
        return migratedUserTickerIds
    }
    
    private var oldTickersFromFile: [OldTicker]? {
        guard let decodedTickersFromFile = UserDefaults.oldShared?.object(forKey: oldUserDataTickersObjectName) as? Data else { return nil }
        
        return try? JSONDecoder().decode([OldTicker].self, from: decodedTickersFromFile)
    }
    
}

// MARK: - Helpers

private extension UserDefaults {
    
    static let oldShared = UserDefaults(suiteName: "group.com.albinek.ios.BitBay-Ticker.shared.defaults")
    
}

private struct OldTicker: Decodable {
    
    struct OldCurrency: Decodable {
        
        var currency: String?
        var minimumOffer: Double?
        var scale: Int?
        
    }
    
    let id: String
    
    let firstCurrency: OldCurrency?
    let secondCurrency: OldCurrency?
    let highestBid: Double?
    let lowestAsk: Double?
    let rate: Double?
    let previousRate: Double?
    let highestRate: Double?
    let lowestRate: Double?
    let volume: Double?
    let average: Double?
    
}
