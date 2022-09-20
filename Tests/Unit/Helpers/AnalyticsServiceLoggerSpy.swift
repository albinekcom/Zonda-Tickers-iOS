@testable import Zonda_Tickers
import XCTest

final class AnalyticsServiceLoggerSpy: AnalyticsServiceLogger {
    
    private(set) var loggedViews: [[AnalyticsService.Track.ParameterKey: String]?] = []
    private(set) var loggedEvents: [(AnalyticsService.Track.Name, [AnalyticsService.Track.ParameterKey: String]?)] = []
    
    func logView(parameters: [AnalyticsService.Track.ParameterKey: String]?) {
        loggedViews.append(parameters)
    }
    
    func logEvent(
        name: AnalyticsService.Track.Name,
        parameters: [AnalyticsService.Track.ParameterKey: String]?
    ) {
        loggedEvents.append((name, parameters))
    }
    
}

extension AnalyticsServiceLoggerSpy {
    
    func assert(expectedLoggedEvents: [(AnalyticsService.Track.Name, [AnalyticsService.Track.ParameterKey: String]?)]) {
        XCTAssertEqual(expectedLoggedEvents.count, loggedEvents.count)
        
        for (index, expectedValue) in expectedLoggedEvents.enumerated() {
            XCTAssertEqual(expectedValue.0, loggedEvents[index].0)
            XCTAssertEqual(expectedValue.1, loggedEvents[index].1)
        }
    }
    
}
