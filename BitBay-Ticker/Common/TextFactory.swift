import UIKit

struct TextFactory {
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        return dateFormatter
    }()
    
    private static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        
        return numberFormatter
    }()
    
    static func makeLastUpdateDateText(updateDate: Date, timeZone: TimeZone? = nil) -> String {
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        
        return "\(NSLocalizedString("last.updated.on", comment: "")) \(dateFormatter.string(from: updateDate))"
    }
    
    static func makeFormattedCurrencyValueString(for value: Double?, isFiat: Bool) -> String {
        if isFiat {
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        } else {
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 10
        }
        
        let valueString: String
        
        if let string = numberFormatter.string(for: value) {
            valueString = string
        } else {
            valueString = "-"
        }
        
        return valueString
    }
    
}
