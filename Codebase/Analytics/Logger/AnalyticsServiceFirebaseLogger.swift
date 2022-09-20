import Firebase

final class AnalyticsServiceFirebaseLogger: AnalyticsServiceLogger {
    
    private let analyticsType: Analytics.Type
    
    init(analyticsType: Analytics.Type = Analytics.self) {
        self.analyticsType = analyticsType
        
        #if !TESTING
            FirebaseApp.configure()
        #endif
    }
    
    func logView(parameters: [AnalyticsService.Track.ParameterKey: String]? = nil) {
        analyticsType.logEvent(
            AnalyticsEventScreenView,
            parameters: parameters?.analyticsParameters
        )
    }
    
    func logEvent(
        name: AnalyticsService.Track.Name,
        parameters: [AnalyticsService.Track.ParameterKey: String]? = nil
    ) {
        analyticsType.logEvent(
            name.rawValue,
            parameters: parameters?.analyticsParameters
        )
    }
    
}

private extension Dictionary where Key == AnalyticsService.Track.ParameterKey, Value == String {
    
    var analyticsParameters: [String: Any] {
        reduce(into: [String: String]()) { $0[$1.key.rawValue] = $1.value }
    }
    
}
