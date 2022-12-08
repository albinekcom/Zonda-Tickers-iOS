import SwiftUI

extension Ticker {
    
    var firstCurrencyText: String {
        firstCurrency.id.uppercased()
    }
    
    var firstCurrencyName: String {
        firstCurrency.name ?? "-"
    }
    
    var secondCurrencyText: String {
        secondCurrency.id.uppercased()
    }
    
    var title: String {
        firstCurrencyText + " \\ " + secondCurrencyText
    }
    
    var shortTitle: String {
        firstCurrencyText + "\\" + secondCurrencyText
    }
    
    var rateText: String {
        defaultPretty(value: rate)
    }
    
    var changeImageName: Image.SystemName {
        (changeRatio ?? 0) == 0 ? .squareFill : .arrowTriangleUpFill
    }
    
    var changeColor: Color {
        guard let changeRatio = changeRatio else { return .secondary }
        
        return changeRatio > 0 ? .green : changeRatio < 0 ? .red : .orange
    }
    
    var changeText: String {
        change?.pretty(precision: secondCurrency.precision, positivePrefix: "+") ?? "-"
    }
    
    var percentageChangeWithPositiveSignText: String {
        changeRatio?.pretty(precision: 2, numberStyle: .percent, positivePrefix: "+") ?? "-"
    }
    
    var percentageChangeWithoutSignText: String {
        changeRatio?.pretty(precision: 2, numberStyle: .percent, negativePrefix: "") ?? "-"
    }
    
    var previousRateText: String {
        defaultPretty(value: previousRate)
    }
    
    var highestRateText: String {
        defaultPretty(value: highestRate)
    }
    
    var lowestRateText: String {
        defaultPretty(value: lowestRate)
    }
    
    var highestBidText: String {
        defaultPretty(value: highestBid)
    }
    
    var lowestAskText: String {
        defaultPretty(value: lowestAsk)
    }
    
    var averageText: String {
        defaultPretty(value: average)
    }
    
    var volumeText: String {
        volume?.pretty(precision: nil) ?? "-"
    }
    
    var volumeValueText: String {
        defaultPretty(value: volumeValue)
    }
    
    private func defaultPretty(value: Double?) -> String {
        value?.pretty(precision: secondCurrency.precision) ?? "-"
    }
    
}
