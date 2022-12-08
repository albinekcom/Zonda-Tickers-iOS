extension Ticker {
    
    var detailRowViewModels: [DetailRowView.Model] { [
        .init(title: "Name", valueText: firstCurrencyName),
        .init(title: "Rate", valueText: rateText),
        .init(title: "Change", valueText: changeText, valueColor: changeColor),
        .init(title: "Change (%)", valueText: percentageChangeWithPositiveSignText, valueColor: changeColor),
        .init(title: "Previous rate", valueText: previousRateText),
        .init(title: "Highest rate", valueText: highestRateText),
        .init(title: "Lowest rate", valueText: lowestRateText),
        .init(title: "Bid", valueText: highestBidText),
        .init(title: "Ask", valueText: lowestAskText),
        .init(title: "Average", valueText: averageText),
        .init(title: "Volume", valueText: volumeText),
        .init(title: "Volume value", valueText: volumeValueText)
    ] }
    
}
