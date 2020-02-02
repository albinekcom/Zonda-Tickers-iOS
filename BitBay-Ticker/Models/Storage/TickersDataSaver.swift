import Foundation

final class TickersDataSaver {
    
    func saveTickers(tickers: [Ticker]) {
        DispatchQueue.global(qos: .background).async {
            UserDefaults.shared?.set(try? JSONEncoder().encode(tickers), forKey: AppConfiguration.Storing.userDataTickersFileName)
        }
    }
    
}

extension UserDefaults {
    
    static let shared = UserDefaults(suiteName: AppConfiguration.Storing.sharedDefaultsIdentifier)
    
}
