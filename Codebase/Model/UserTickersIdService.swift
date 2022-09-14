final class UserTickersIdService {
    
    private let localDataService: LocalDataService
    
    init(localDataService: LocalDataService = FileManagerDataService()) {
        self.localDataService = localDataService
    }
    
    var loaded: [String] {
        localDataService.loadUserTickersId()
    }
    
    func save(userTickersId: [String]) {
        localDataService.save(userTickersId: userTickersId)
    }
    
}
