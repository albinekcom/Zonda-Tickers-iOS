import UIKit

struct WidgetConfiguration {
    
    struct Cell {
        
        static let height: CGFloat = 50
        static let margin: CGFloat = 8
        static let iconSize: CGFloat = 24
        
    }
    
    static let maximumVisibleTickersCount: Int = 12
    static let applicationURL: URL? = URL(string: "BitBay-Ticker://")
}
