import SwiftUI

struct TickerDetailViewModel {
    
    enum Row {
        case rate
        case previousRate
        case highestRate
        case lowestRate
        case highestBid
        case lowestAsk
        case average
        case volume
    }
    
    let model: Ticker
    
    var navigationBarTitle: Text {
        Text(model.title)
    }
    
    func title(for row: Row) -> Text {
        switch row {
        case .rate:
            return Text("ticker.details.last")
            
        case .previousRate:
            return Text("ticker.details.previous")
            
        case .highestRate:
            return Text("ticker.details.maximum")
            
        case .lowestRate:
            return Text("ticker.details.minimum")
            
        case .highestBid:
            return Text("ticker.details.bid")
            
        case .lowestAsk:
            return Text("ticker.details.ask")
            
        case .average:
            return Text("ticker.details.average")
            
        case .volume:
            return Text("ticker.details.volume")
        }
    }
    
    func value(for row: Row) -> String {
        let value: Double?
        let scale = model.secondCurrency?.scale
        var currencyString = model.secondCurrency?.currency
        
        switch row {
        case .rate:
            value = model.rate
            
        case .previousRate:
            value = model.previousRate
            
        case .highestRate:
            value = model.highestRate
            
        case .lowestRate:
            value = model.lowestRate
            
        case .highestBid:
            value = model.highestBid
            
        case .lowestAsk:
            value = model.lowestAsk
            
        case .average:
            value = model.average
            
        case .volume:
            value = model.volume
            currencyString = nil
        }
        
        return PrettyValueFormatter.makePrettyString(value: value, scale: scale, currency: currencyString)
    }
    
}
