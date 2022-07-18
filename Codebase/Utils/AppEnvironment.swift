import Foundation

final class AppEnvironment: ObservableObject {
    
    let analyticsService: AnalyticsService
    
    init(analyticsService: AnalyticsService) {
        self.analyticsService = analyticsService
    }
}
