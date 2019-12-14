struct TickerStatisticsAPIResponse: Codable {
    
    struct StatisticsAPIResponse: Codable {
        let m: String?
        let h: String?
        let l: String?
        let v: String?
        let r24h: String?
    }
    
    let status: String?
    let stats: StatisticsAPIResponse?
    
}
