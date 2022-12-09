import WatchConnectivity

protocol ConnectivityProvider: AnyObject {
    
    func updateUserTickerIds(_ userTickerIds: [String])
    
    var delegate: ConnectivityProviderDelegate? { get set }
}

protocol ConnectivityProviderDelegate: AnyObject {
    
    var userTickerIds: [String] { get }
}

protocol WCSessionProtocol: AnyObject {
    
    func activate()
    func updateApplicationContext(_ applicationContext: [String: Any]) throws
    func transferCurrentComplicationUserInfo(_ userInfo: [String: Any]) -> WCSessionUserInfoTransfer
    
    var delegate: WCSessionDelegate? { get set }
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
    
    func updateUserTickerIds(_ userTickerIds: [String]) {
        let message = [WatchConnectivityKey.Parameter.userTickerIds: userTickerIds]
        
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
