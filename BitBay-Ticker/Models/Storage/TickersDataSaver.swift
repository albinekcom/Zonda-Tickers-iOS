import Foundation

struct TickersDataSaver {
    
    func saveTickers(tickers: [Ticker]) {
        DispatchQueue.global(qos: .background).async {
            Storage.store(tickers, to: .documents, as: AppConfiguration.Storing.userDataTickersFileName)
        }
    }
    
}
