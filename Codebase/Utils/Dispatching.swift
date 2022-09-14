import Foundation

protocol Dispatching {
    
    func async(execute work: @escaping @convention(block) () -> Void)
    
}
 
extension DispatchQueue: Dispatching {
    
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(
            group: nil,
            qos: qos,
            flags: [],
            execute: work
        )
    }
    
}
