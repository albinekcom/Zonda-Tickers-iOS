import UIKit

final class TickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var trendView: TrendView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let trendViewBackgroundColor = trendView.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        if selected {
            trendView.backgroundColor = trendViewBackgroundColor
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let trendViewBackgroundColor = trendView.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            trendView.backgroundColor = trendViewBackgroundColor
        }
    }

}
