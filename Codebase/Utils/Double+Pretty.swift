import Foundation

extension Double {
    
    func pretty(
        precision: Int?,
        numberStyle: NumberFormatter.Style = .decimal,
        positivePrefix: String = "",
        negativePrefix: String = "-"
    ) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        formatter.positivePrefix = self == 0 ? "" : positivePrefix
        formatter.negativePrefix = negativePrefix
        
        if let precision = precision {
            formatter.minimumFractionDigits = precision
            formatter.maximumFractionDigits = precision
        }
        
        return formatter.string(from: NSNumber(value: self))
    }
    
}
