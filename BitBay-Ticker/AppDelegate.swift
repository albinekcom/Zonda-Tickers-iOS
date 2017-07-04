import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    
    var window: UIWindow?
    
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()
        
        TickerStore.shared.loadUserData()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        TickerStore.shared.saveUserData()
    }
    
}
