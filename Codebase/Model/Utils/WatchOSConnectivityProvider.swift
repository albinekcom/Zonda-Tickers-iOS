import WatchConnectivity

protocol ConnectivityProvider {
    
    func send(tickers: [Ticker])
    func send(userTickerIds: [String])
}

final class WatchOSConnectivityProvider: NSObject, ConnectivityProvider {
    
    private let session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        
        super.init()
        
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    func send(tickers: [Ticker]) {
        send(message: ["tickers": tickers])
    }
    
    func send(userTickerIds: [String]) {
        send(message: ["userTickerIds": userTickerIds])
    }
    
    private func send(message: [String: Any]) {
        guard session.isReachable else { return }
        
        session.sendMessage(message, replyHandler: { _ in } )
    }
    
}

extension WatchOSConnectivityProvider: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}
    
}
