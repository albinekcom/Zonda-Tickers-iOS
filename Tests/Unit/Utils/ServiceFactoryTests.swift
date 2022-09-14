import Firebase
import XCTest
@testable import Zonda_Tickers

final class ServiceFactoryTests: XCTestCase {
    
    func test_makeLocalDataService() {
        XCTAssertTrue(ServiceFactory.withEmptyArguments.makeLocalDataService() is FileManagerDataService)
        XCTAssertTrue(ServiceFactory.withUITestArguments.makeLocalDataService() is LocalDataServiceUITestsStub)
    }
    
    func test_makeTickerFetcher() {
        XCTAssertTrue(ServiceFactory.withEmptyArguments.makeTickerFetcher() is TickerWebService)
        XCTAssertTrue(ServiceFactory.withUITestArguments.makeTickerFetcher() is TickerFetcherUITestsStub)
        
        XCTAssertEqual(.standard, (ServiceFactory.withUITestArguments.makeTickerFetcher() as! TickerFetcherUITestsStub).variant)
        XCTAssertEqual(.error, (ServiceFactory.withUITestAndTickerFetcherThrowsErrorArguments.makeTickerFetcher() as! TickerFetcherUITestsStub).variant)
    }
    
    func test_makeFirebaseConfigurableType() {
        XCTAssertTrue(ServiceFactory.withEmptyArguments.makeFirebaseConfigurableType() is FirebaseApp.Type)
        XCTAssertTrue(ServiceFactory.withUITestArguments.makeFirebaseConfigurableType() is FirebaseAppDummy.Type)
    }
    
}

private extension ServiceFactory {
    
    static var withEmptyArguments: ServiceFactory {
        .init(appArguments: .init(arguments: []))
    }
    
    static var withUITestArguments: ServiceFactory {
        .init(appArguments: .init(arguments: [AppArguments.uiTestsKey]))
    }
    
    static var withUITestAndTickerFetcherThrowsErrorArguments: ServiceFactory {
        .init(appArguments: .init(arguments: [AppArguments.uiTestsKey, AppArguments.tickerFetcherThrowsErrorKey]))
    }
    
}
