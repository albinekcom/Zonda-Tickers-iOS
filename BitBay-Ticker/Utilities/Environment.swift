import UIKit

struct Environment {
    
    static func variable(forKey key: String) -> String? {
        guard let rawValue = getenv(key) else { return nil }
        
        return String(utf8String: rawValue)
    }
    
    static func setVariable(name: String, value: String, overwrite: Bool) {
        setenv(name, value, overwrite ? 1 : 0)
    }
    
}

extension Environment {
    
    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    static var areFetchingRealTickers: Bool {
        return UserDefaults.standard.bool(forKey: "areFetchingRealTickers")
    }
    
}
