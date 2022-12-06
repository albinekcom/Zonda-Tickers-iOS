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
