import Foundation

struct PlistFile {
    
    let name: String
    
    var dictionary: [String: Any]? {
        guard let destinationPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).plist").path else { return nil }
        
        return NSDictionary(contentsOfFile: destinationPath) as? [String: Any]
    }
    
}
