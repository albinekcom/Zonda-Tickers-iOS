import UIKit

final class WidgetTableViewCell: UITableViewCell {
    
    var firstCurrency: String = "" {
        didSet {
            firstCurrencyLabel.text = firstCurrency
            iconView.image = UIImage(named: firstCurrency)
        }
    }
    
    var secondCurrency: String = "" {
        didSet {
            secondCurrencyLabel.text = "\\ \(secondCurrency)"
        }
    }
    
    var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }
    
    private let iconView: UIImageView = UIImageView()
    private let firstCurrencyLabel: UILabel = UILabel()
    private let secondCurrencyLabel: UILabel = UILabel()
    private let valueLabel: UILabel = UILabel()
    private let stackView: UIStackView = UIStackView()
    
    // MARK: - Initializing
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpSubviews()
        setUpViewsHierarchy()
        setUpConstraints()
    }
    
    // MARK: - Setting
    
    private func setUpSubviews() {
        firstCurrencyLabel.font = .preferredFont(forTextStyle: .headline)
        firstCurrencyLabel.textColor = .label
        
        secondCurrencyLabel.font = .preferredFont(forTextStyle: .footnote)
        secondCurrencyLabel.textColor = .secondaryLabel
        
        valueLabel.font = .preferredFont(forTextStyle: .subheadline)
        valueLabel.textColor = .label
    }
    
    private func setUpViewsHierarchy() {
        addSubview(iconView)
        addSubview(firstCurrencyLabel)
        addSubview(secondCurrencyLabel)
        addSubview(valueLabel)
    }
    
    private func setUpConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: WidgetConfiguration.Cell.margin),
                iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconView.widthAnchor.constraint(equalToConstant: WidgetConfiguration.Cell.iconSize),
                iconView.heightAnchor.constraint(equalToConstant: WidgetConfiguration.Cell.iconSize)
            ]
        )
        
        firstCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                firstCurrencyLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: WidgetConfiguration.Cell.margin),
                firstCurrencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
        
        secondCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                secondCurrencyLabel.leadingAnchor.constraint(equalTo: firstCurrencyLabel.trailingAnchor, constant: WidgetConfiguration.Cell.margin / 2),
                secondCurrencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(WidgetConfiguration.Cell.margin / 2))
            ]
        )
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -WidgetConfiguration.Cell.margin),
                valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                valueLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.5)
            ]
        )
    }
    
}
