import SwiftUI

@main
private struct MainApp: App {
    
    @StateObject private var modelData = ModelData()
    @StateObject private var appEnvironment = AppEnvironment()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(modelData)
                .environmentObject(appEnvironment)
        }
    }
    
}

// TODO:
// - Get initial data in "watchOS App" ("iOSConnectivityReceiver" class, link: https://developer.apple.com/forums/thread/13116)
// - Refresh "watchOS App" when it is in the background
// - Check refreshing "Complications" from iOS App (probably it will work automaticly when watchOS refresh in the background shared data)
// - Add unit tests for "WatchOSConnectivityProvider" class
