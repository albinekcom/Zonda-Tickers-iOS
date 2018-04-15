import UIKit

extension UIColor {
    
    static var primary: UIColor {
        return UIColor(displayP3Red: 41/255, green: 102/255, blue: 187/255, alpha: 1)
    }
    
    static var refreshControl: UIColor {
        return UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    static var positiveTrend: UIColor {
        return UIColor(displayP3Red: 84/255, green: 215/255, blue: 105/255, alpha: 1)
    }
    
    static var negativeTrend: UIColor {
        return UIColor(displayP3Red: 251/255, green: 61/255, blue: 56/255, alpha: 1)
    }
    
    static var trendText: UIColor {
        return .white
    }
    
}
