import Foundation

final class AutomaticMethodInvoker: ObservableObject {
    
    var invokeMethod: (() async -> Void)?
    
    private let interval: TimeInterval
    
    init(interval: TimeInterval = .default) {
        self.interval = interval
    }
    
    func start() {
        Task {
            await fire()
        }
    }
    
    private func fire() async {
        await invokeMethod?()
        
        try? await Task.sleep(nanoseconds: UInt64(interval) * 1_000_000_000)
        
        start()
    }
    
}

private extension TimeInterval {
    
    static let `default`: TimeInterval = 15
    
}
