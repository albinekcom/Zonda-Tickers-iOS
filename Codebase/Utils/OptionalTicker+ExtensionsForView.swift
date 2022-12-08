import SwiftUI

extension Optional where Wrapped == Ticker {
    
    var change: Double {
        self?.change ?? 0
    }
    
    var changeColor: Color {
        self?.changeColor ?? .secondary
    }
    
    var changeImageName: Image.SystemName {
        self?.changeImageName ?? .squareFill
    }
    
    var firstCurrencyText: String {
        self?.firstCurrencyText ?? "-"
    }
    
    var percentageChangeWithoutSignText: String {
        self?.percentageChangeWithoutSignText ?? "-"
    }
    
    var percentageChangeWithPositiveSignText: String {
        self?.percentageChangeWithPositiveSignText ?? "-"
    }
    
    var rateText: String {
        self?.rateText ?? "-"
    }
    
    var secondCurrencyText: String {
        self?.secondCurrencyText ?? "-"
    }
    
    var shortTitle: String {
        self?.shortTitle ?? "-\\-"
    }
    
    var title: String {
        self?.title ?? "- \\ -"
    }
    
}
