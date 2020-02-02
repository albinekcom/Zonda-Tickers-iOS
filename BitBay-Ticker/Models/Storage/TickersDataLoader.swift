import Foundation

final class TickersDataLoader {
    
    func loadTickersAsynchronously(completion: (([Ticker]?) -> (Void))? = nil) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let tickers = self?.tickersFromFile
            
            DispatchQueue.main.async {
                completion?(tickers)
            }
        }
    }
    
    func loadTickersSynchronously() -> [Ticker]? {
        return tickersFromFile
    }
    
    private var tickersFromFile: [Ticker]? {
        let tickersFromFile: [Ticker]?
        
        if let decodedTickersFromFile = UserDefaults.shared?.object(forKey: AppConfiguration.Storing.userDataTickersFileName) as? Data {
            tickersFromFile = try? JSONDecoder().decode([Ticker].self, from: decodedTickersFromFile)
        } else {
            tickersFromFile = nil
        }
        
        return tickersFromFile
    }
    
}
