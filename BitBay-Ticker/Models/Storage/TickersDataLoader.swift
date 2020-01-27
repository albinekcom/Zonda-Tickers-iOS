import Foundation

struct TickersDataLoader {
    
    func loadTickers(completion: (([Ticker]?) -> (Void))? = nil) {
        guard Storage.fileExists(AppConfiguration.Storing.userDataTickersFileName, in: .documents) else {
            completion?(nil)
            
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            let tickersFromFile = Storage.retrieve(AppConfiguration.Storing.userDataTickersFileName, from: .documents, as: [Ticker].self)
            
            DispatchQueue.main.async {
                completion?(tickersFromFile)
            }
        }
    }
    
}
