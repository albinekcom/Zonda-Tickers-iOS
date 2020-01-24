struct AvailableTickersAPIResponse: Codable {
    
    struct DataAPIResponse: Codable {
        
        let availableTickers: [String]?
        let sortingOrder: [String]?
        
    }
    
    let data: DataAPIResponse?
    
}

