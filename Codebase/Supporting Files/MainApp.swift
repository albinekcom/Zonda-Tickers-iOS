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
// - Add tickers fetcher in watchOS
// - Pass data to watchOS Complications
// - dd tickers fetcher in watchOS Complications
// - Fix localizaing on Details view on iOS
// - Fix localizaing on Details view on watchOS
// - Add unit tests for "WatchOSConnectivityProvider" class
