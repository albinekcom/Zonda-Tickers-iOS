import SwiftUI

struct TickerDetailViewModel {
    
    enum Row {
        case rate
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
            
        case .highestRate:
            return Text("ticker.details.max")
            
        case .lowestRate:
            return Text("ticker.details.min")
            
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
        switch row {
        case .rate:
            return "\(model.rate ?? 0)" // TODO: Improve the final look of this string
            
        case .highestRate:
            return "\(model.highestRate ?? 0)" // TODO: Improve the final look of this string
            
        case .lowestRate:
            return "\(model.lowestRate ?? 0)" // TODO: Improve the final look of this string
            
        case .highestBid:
            return "\(model.highestBid ?? 0)" // TODO: Improve the final look of this string
            
        case .lowestAsk:
            return "\(model.lowestAsk ?? 0)" // TODO: Improve the final look of this string
            
        case .average:
            return "\(model.average ?? 0)" // TODO: Improve the final look of this string
            
        case .volume:
            return "\(model.volume ?? 0)" // TODO: Improve the final look of this string
        }
    }
    
}
