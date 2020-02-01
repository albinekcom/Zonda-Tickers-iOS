struct TickerStatisticsAPIResponse: Codable {
    
    let status: String?
    let stats: StatisticsAPIResponse?
    
    struct StatisticsAPIResponse: Codable {
        let m: String?
        let h: String?
        let l: String?
        let v: String?
        let r24h: String?
    }
    
}
