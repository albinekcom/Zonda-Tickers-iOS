import UIKit

struct TextFactory {
    
    private static let dateFormatter = DateFormatter()
    private static let numberFormatter = NumberFormatter()
    
    static func makeLastUpdateDateText(updateDate: Date, timeZone: TimeZone? = nil) -> String {
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        
        return "\(NSLocalizedString("last.updated.on", comment: "")) \(dateFormatter.string(from: updateDate))"
    }
    
    static func makeFormattedCurrencyValueString(for value: Double?, isFiat: Bool) -> String {
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .decimal
        numberFormatter.generatesDecimalNumbers = true
        
        if isFiat {
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        } else {
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 10
        }
        
        let valueString: String
        
        if let value = value, let string = numberFormatter.string(for: value) {
            valueString = string
        } else {
            valueString = "-"
        }
        
        return valueString
    }
    
}
