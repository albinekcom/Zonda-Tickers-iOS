import UIKit

struct TextFactory {
    
    static func makeLastUpdateDateText(updateDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return "\(NSLocalizedString("last.updated.on", comment: "")) \(dateFormatter.string(from: updateDate))"
    }

}
