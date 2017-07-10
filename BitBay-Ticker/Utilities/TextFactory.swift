import UIKit

struct TextFactory {
    
    static func makeLastUpdateDateText(updateDate: Date, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        
        return "\(NSLocalizedString("last.updated.on", comment: "")) \(dateFormatter.string(from: updateDate))"
    }

}
