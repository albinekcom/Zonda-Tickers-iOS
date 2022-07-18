struct CurrenciesNamesAPIResponse: Decodable {
    
    let names: [String: String]
    
}

struct TickersValuesAPIResponse: Decodable {
    
    struct Item: Decodable {
        
        struct Market: Decodable {
            
            struct Currency: Decodable {
                
                let currency: String
                let minOffer: String?
                let scale: Int
                
            }
            
            let code: String
            let first: Currency
            let second: Currency
            
        }
        
        let market: Market
        let time: String?
        let highestBid: String?
        let lowestAsk: String?
        let rate: String?
        let previousRate: String?
    }
    
    let status: String
    
    let items: [String: Item]
}

struct TickersStatisticsAPIResponse: Decodable {
    
    struct Item: Decodable {
        
        let m: String
        let h: String?
        let l: String?
        let v: String?
        let r24h: String?
    }
    
    let status: String
    
    let items: [String: Item]
    
}
