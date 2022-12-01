import SwiftUI

@main
private struct WatchApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
                    .environmentObject(modelData)
            }
        }
    }
    
}
