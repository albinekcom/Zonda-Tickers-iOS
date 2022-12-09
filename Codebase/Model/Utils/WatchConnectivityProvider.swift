import WatchConnectivity

protocol ConnectivityProvider: AnyObject {
    
    func update(tickers: [Ticker], userTickerIds: [String])
    
    var delegate: ConnectivityProviderDelegate? { get set }
}

protocol ConnectivityProviderDelegate: AnyObject {
    
    var userTickerIds: [String] { get }
}

protocol WCSessionProtocol: AnyObject {
    
    var delegate: WCSessionDelegate? { get set }
    
    func activate()
    func updateApplicationContext(_ applicationContext: [String: Any]) throws
    func transferCurrentComplicationUserInfo(_ userInfo: [String: Any]) -> WCSessionUserInfoTransfer
    
}

extension WCSession: WCSessionProtocol {}

final class WatchConnectivityProvider: NSObject, ConnectivityProvider {
    
    private let session: WCSessionProtocol
    
    weak var delegate: ConnectivityProviderDelegate?
    
    init(session: WCSessionProtocol = WCSession.default) {
        self.session = session
        
        super.init()
        
        session.delegate = self
        session.activate()
    }
    
    func update(tickers: [Ticker], userTickerIds: [String]) {
        let message: [String: Any] = [
            WatchConnectivityKey.Parameter.tickers: tickers.map(\.jsonString),
            WatchConnectivityKey.Parameter.userTickerIds: userTickerIds
        ]
        
        try? session.updateApplicationContext(message)
        _ = session.transferCurrentComplicationUserInfo(message)
    }
    
}

extension WatchConnectivityProvider: WCSessionDelegate {
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {}
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
}
