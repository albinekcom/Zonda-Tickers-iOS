import WatchConnectivity
import WatchKit

final class iOSConnectivityReceiver: NSObject {
    
    @Published private(set) var tickers: [Ticker] = []
    @Published private(set) var userTickersIds: [String] = []
    
    private let session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        
        super.init()
        
        session.delegate = self
        session.activate()
    }
    
}

extension iOSConnectivityReceiver: WCSessionDelegate {
    
    func session(
        _ session: WCSession,
        didReceiveMessage message: [String: Any],
        replyHandler: @escaping ([String: Any]) -> Void
    ) {
        print("didReceiveMessage invoked")
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let tickers = message["tickers"] as? [Ticker] {
                self.tickers = tickers
            }
            
            if let userTickersIds = message["userTickerIds"] as? [String] {
                self.userTickersIds = userTickersIds
            }
        }
    }
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
        print("activationDidCompleteWith invoked")
    }
    
    func session(
        _ session: WCSession,
        didReceiveApplicationContext applicationContext: [String: Any]
    ) {
        print("didReceiveApplicationContext invoked")
    }
    
}
