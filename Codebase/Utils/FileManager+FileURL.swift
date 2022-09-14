import Foundation

protocol SharedContainer {
    
    func fileURL(for fileName: FileManagerDataService.FileName) -> URL?
    
}

extension FileManager: SharedContainer {
    
    func fileURL(for fileName: FileManagerDataService.FileName) -> URL? {
        containerURL(forSecurityApplicationGroupIdentifier: "group.com.zonda-tickers")?.appendingPathComponent(fileName.rawValue + ".json")
    }
    
}
