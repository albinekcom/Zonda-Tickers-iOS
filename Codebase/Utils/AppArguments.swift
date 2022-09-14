struct AppArguments {
    
    static let uiTestsKey = "-ui-tests"
    static let tickerFetcherThrowsErrorKey = "-ticker-fetcher-throws-error"
    
    private let arguments: [String]
    
    init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    var isUITest: Bool {
        arguments.contains(Self.uiTestsKey)
    }
    
    var isTickerFetcherThrowingError: Bool {
        arguments.contains(Self.tickerFetcherThrowsErrorKey)
    }
    
}
