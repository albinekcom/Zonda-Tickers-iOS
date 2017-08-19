import Foundation

struct TrendViewValueStringFactory {
    
    private static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .decimal
        numberFormatter.positivePrefix = numberFormatter.plusSign
        
        return numberFormatter
    }()
    
    static func makeValueString(from value: Double?) -> String {
        guard var value = value else { return "-" }
        
        if abs(value) >= 999 {
            switch value.sign {
            case .plus:
                value = 999
            case .minus:
                value = -999
            }
        }
        
        if value != 0 && abs(value) < 0.01 {
            switch value.sign {
            case .plus:
                value = 0.01
            case .minus:
                value = -0.01
            }
        }
        
        if abs(value) >= 100 && abs(value) <= 999 {
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 0
        } else if abs(value) >= 10 && abs(value) < 100 {
            numberFormatter.minimumFractionDigits = 1
            numberFormatter.maximumFractionDigits = 1
        } else if abs(value) >= 0.01 && abs(value) < 10 {
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        } else if value == 0 {
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
        }
        
        guard let formattedValue = numberFormatter.string(for: value) else { return "-" }
        
        return "\(formattedValue)%"
    }
    
}
