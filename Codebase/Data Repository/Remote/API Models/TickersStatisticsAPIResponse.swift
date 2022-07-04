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
