import UIKit

final class TrendView: UIView {
    
    var value: Double? {
        didSet {
            valueLabel.text = TrendViewValueStringFactory.makeValueString(from: value)
            
            guard let value = value else {
                backgroundColor = UIColor.positiveTrend
                
                return
            }
            
            switch value.sign {
            case .plus:
                backgroundColor = UIColor.positiveTrend
            case .minus:
                backgroundColor = UIColor.negativeTrend
            }
        }
    }
    
    private let valueLabel = UILabel()
    
    // MARK: - Initializing
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: - Setting
    
    private func setup() {
        setupValueLabel()
        setupBackground()
        
        addSubview(valueLabel)
    }
    
    func setupValueLabel() {
        valueLabel.textColor = UIColor.trendText
        valueLabel.textAlignment = .center
    }
    
    func setupBackground() {
        layer.cornerRadius = 4.0
    }
    
    // MARK: - Layouting
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        valueLabel.frame = bounds
    }
    
}
