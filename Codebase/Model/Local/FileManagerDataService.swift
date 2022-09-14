import Foundation

final class FileManagerDataService: LocalDataService {
    
    enum FileName: String {
        
        case tickers
        case userTickerIds = "user_ticker_ids"
        
    }
    
    private let sharedContainer: SharedContainer
    private let saveDispatchQueue: Dispatching
    
    init(
        sharedContainer: SharedContainer = FileManager.default,
        saveDispatchQueue: Dispatching = DispatchQueue.global(qos: .background)
    ) {
        self.sharedContainer = sharedContainer
        self.saveDispatchQueue = saveDispatchQueue
    }
    
    // MARK: - Loading
    
    func loadUserTickersId() -> [String] {
        load(from: .userTickerIds) ?? [String]()
    }
    
    func loadTickers() -> [Ticker] {
        load(from: .tickers) ?? [Ticker]()
    }
    
    // MARK: - Saving
    
    func save(userTickersId: [String]) {
        save(userTickersId, in: .userTickerIds)
    }
    
    func save(tickers: [Ticker]) {
        save(tickers, in: .tickers)
    }
    
    // MARK: - Private
    
    private func load<T: Decodable>(from fileName: FileName) -> T? {
        guard let fileURL = sharedContainer.fileURL(for: fileName),
              let jsonData = try? Data(contentsOf: fileURL) else { return nil }
        
        return try? JSONDecoder().decode(
            T.self,
            from: jsonData
        )
    }

    private func save<T: Encodable>(_ data: T, in fileName: FileName) {
        guard let fileURL = sharedContainer.fileURL(for: fileName) else { return }
        
        saveDispatchQueue.async {
            try? JSONEncoder().encode(data).write(to: fileURL)
        }
    }
    
}
