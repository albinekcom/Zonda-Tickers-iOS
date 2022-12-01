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
// - Get initial data for "iOSConnectivityReceiver" class
// - Add tickers fetcher in "Watch App"
// - Pass data to "Watch Complications"
// - Add tickers fetcher in "Watch Complications"
// - Add unit tests for "WatchOSConnectivityProvider" class
