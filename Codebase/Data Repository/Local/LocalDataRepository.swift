import Foundation

final class LocalDataRepository {
    
    enum FileName: String {
        
        case tickers
        case userTickerIds = "user_ticker_ids"
        
    }
    
    private let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    // MARK: - Loading
    
    func loadTickers() -> [Ticker]? {
        load(from: .tickers)
    }
    
    func loadUserTickerIds() -> [String]? {
        let userTickerIds: [String]?
        
        if let migratedUserTickerIds = OldLocalDataRepositoryMigrator().userTickerIds {
            userTickerIds = migratedUserTickerIds
        } else {
            userTickerIds = load(from: .userTickerIds)
        }
        
        return userTickerIds
    }
    
    private func load<T: Decodable>(from fileName: FileName) -> T? {
        guard let fileUrl = fileURL(fileName: fileName),
              let jsonData = try? Data(contentsOf: fileUrl) else { return nil }
        
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }
    
    // MARK: - Saving
    
    func saveTickers(_ tickers: [Ticker]) {
        save(tickers, in: .tickers)
    }
    
    func saveUserTickerIds(_ userTickerIds: [String]) {
        save(userTickerIds, in: .userTickerIds)
    }
    
    private func save<T: Encodable>(_ data: T, in fileName: LocalDataRepository.FileName) {
        guard let fileUrl = fileURL(fileName: fileName) else { return }
        
        DispatchQueue.global(qos: .background).async {
            try? JSONEncoder().encode(data).write(to: fileUrl)
        }
    }
    
    // MARK: - Helpers
    
    private func fileURL(fileName: LocalDataRepository.FileName) -> URL? {
        fileManager
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(fileName.rawValue + ".json")
    }
    
}
