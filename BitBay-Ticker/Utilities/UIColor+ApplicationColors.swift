import UIKit

extension UIColor {
    
    static var primary: UIColor {
        return UIColor(red: 20/255.0, green: 140/255.0, blue: 190/255.0, alpha: 1)
    }
    
    static var refreshControl: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    static var positiveTrend: UIColor {
        return UIColor(red: 84/255.0, green: 215/255.0, blue: 105/255.0, alpha: 1)
    }
    
    static var negativeTrend: UIColor {
        return UIColor(red: 251/255.0, green: 61/255.0, blue: 56/255.0, alpha: 1)
    }
    
    static var trendText: UIColor {
        return .white
    }
    
    static var selectedCell: UIColor {
        return UIColor(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)
    }
    
    static var unselectedCell: UIColor {
        return .white
    }
    
}
