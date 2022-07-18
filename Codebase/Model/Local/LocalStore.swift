import Foundation

enum FileName: String {
    
    case tickers
    case userTickerIds = "user_ticker_ids"
    
}

final class LocalStore {
    
    private let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    func load<T: Decodable>(from fileName: FileName) -> T? {
        guard let fileURL = fileName.fileURL(for: fileManager),
              let jsonData = try? Data(contentsOf: fileURL) else { return nil }
        
        return try? JSONDecoder().decode(
            T.self,
            from: jsonData
        )
    }

    func save<T: Encodable>(_ data: T, in fileName: FileName) {
        guard let fileURL = fileName.fileURL(for: fileManager) else { return }
        
        DispatchQueue.global(qos: .background).async {
            try? JSONEncoder().encode(data).write(to: fileURL)
        }
    }
    
}

private extension FileName {
    
    func fileURL(for fileManager: FileManager) -> URL? {
        fileManager.sharedContainerURL.appendingPathComponent(rawValue + ".json")
    }
    
}

private extension FileManager {
    
    var sharedContainerURL: URL {
        containerURL(forSecurityApplicationGroupIdentifier: "group.com.zonda-tickers")!
    }
    
}
