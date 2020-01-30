import UIKit

extension Optional where Wrapped == String {
    
    var intValue: Int? {
        if let self = self {
            return Int(self)
        } else {
            return nil
        }
    }
    
    var doubleValue: Double? {
        if let self = self {
            return Double(self)
        } else {
            return nil
        }
    }
    
}

extension String {
    
    var color: UIColor {
        var total: Int = 0
        
        for u in unicodeScalars {
            total += Int(UInt32(u))
        }
        
        srand48(total * 200)
        let red = CGFloat(drand48())
        
        srand48(total)
        let green = CGFloat(drand48())
        
        srand48(total / 200)
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
