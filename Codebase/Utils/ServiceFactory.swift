import Firebase

final class ServiceFactory {
    
    private let appArguments: AppArguments
    
    init(appArguments: AppArguments = .init()) {
        self.appArguments = appArguments
    }
    
    func makeLocalDataService() -> LocalDataService {
        appArguments.isUITest ? LocalDataServiceUITestsStub() : FileManagerDataService()
    }
    
    func makeTickerFetcher() -> TickerFetcher {
        appArguments.isUITest ? TickerFetcherUITestsStub(variant: appArguments.isTickerFetcherThrowingError ? .error : .standard) : TickerWebService()
    }
    
    func makeFirebaseConfigurableType() -> FirebaseConfigurable.Type {
        appArguments.isUITest ? FirebaseAppDummy.self : FirebaseApp.self
    }
    
}
