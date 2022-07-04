import UIKit

@main
private final class AppDelegate: NSObject {}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { true }
    
}

// TODO:
//   - Remove old code from disk
//   - Change gif and icon in README.md
//   - Check migration with removed "BitBay-Ticker.entitlements"
//   - Remove old UI tests
//   - Watch sessions about widget
//   - Create a widget
//   - Ship the application to App Store
//   - Add unit tests for "Double+Pretty"
//   - Add unit tests for "String+GeneratedColor"
//   - Add unit tests for "ReviewController"
//   - Add unit tests for "Ticker"
//   - Add unit tests for "TickerRowViewModel"
//   - Add unit tests for "AnalyticsService"
//   - Add unit tests for "OldLocalDataRepositoryMigrator"
//   - Add unit tests for "LocalDataRepository"
//   - Add unit tests for "RemoteDataRepository"
//   - Add unit tests for "DataRepository"
//   - Add unit tests for "ListViewModel"
//   - Add unit tests for "DetailsViewModel"
//   - Add unit tests for "AdderViewModel"
