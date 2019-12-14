struct AvailableTickersAPIResponse: Codable {
    
    struct DataAPIResponse: Codable {
        
        let availableTickers: [String]?
        
    }
    
    let data: DataAPIResponse?
    
}

