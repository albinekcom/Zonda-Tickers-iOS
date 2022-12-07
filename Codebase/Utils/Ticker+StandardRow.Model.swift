extension Ticker {
    
    var standardRowModel: StandardRowView.Model {
        .init(
            firstCurrencyId: firstCurrency.id,
            firstCurrencyText: firstCurrencyText,
            secondCurrencyText: secondCurrencyText,
            rateText: rateText,
            percentageChangeWithoutSignText: percentageChangeWithoutSignText,
            percentageChangeWithPositiveSignText: percentageChangeWithPositiveSignText,
            changeImageName: changeImageName,
            changeColor: changeColor,
            isGain: (change ?? 0) > 0
        )
    }
    
}
