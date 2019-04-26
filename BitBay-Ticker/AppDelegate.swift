import Firebase
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    
    var window: UIWindow?
    
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        TickerStore.shared.loadUserData()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let tickersViewController = window?.rootViewController?.children.first as? TickersViewController else { return }
        
        if tickersViewController.isAutoRefreshingEnabled {
            tickersViewController.removeAutoRefreshingTimer(changeIsAutoRefreshingEnabledFlag: false)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        guard let tickersViewController = window?.rootViewController?.children.first as? TickersViewController else { return }
        
        if tickersViewController.isAutoRefreshingEnabled {
            tickersViewController.scheduleAutoRefreshingTimer(changeIsAutoRefreshingEnabledFlag: false)
        }
    }
    
}
