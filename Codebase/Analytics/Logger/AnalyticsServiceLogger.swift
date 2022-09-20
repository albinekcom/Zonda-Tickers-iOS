protocol AnalyticsServiceLogger {

    func logView(parameters: [AnalyticsService.Track.ParameterKey: String]?)
    func logEvent(name: AnalyticsService.Track.Name, parameters: [AnalyticsService.Track.ParameterKey: String]?)

}
