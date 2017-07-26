import Foundation

struct PlistFile {
    
    let name: String
    
    var isUserDataCreated: Bool {
        guard let destinationPath = destinationPath else { return false }
        
        return FileManager.default.fileExists(atPath: destinationPath)
    }
    
    var dictionary: [String: Any]? {
        guard let destinationPath = destinationPath else { return nil }
        
        return NSDictionary(contentsOfFile: destinationPath) as? [String: Any]
    }
    
    func save(dictionary: [String: Any]) -> Bool {
        guard let destinationPath = destinationPath else { return false }
        
        return NSDictionary(dictionary: dictionary).write(toFile: destinationPath, atomically: true)
    }
    
    private var destinationPath: String? {
        let destinationPath: String?
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            destinationPath = (dir.path as NSString).appendingPathComponent("\(name).plist")
        } else {
            destinationPath = nil
        }
        
        return destinationPath
    }
    
}
