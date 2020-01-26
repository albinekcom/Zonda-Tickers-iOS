import Foundation

extension Int {
    
    var seconds: TimeInterval {
        return TimeInterval(self)
    }
    
    var minutes: TimeInterval {
        return seconds * 60
    }
    
    var hours: TimeInterval {
        return minutes * 60
    }
    
}
