import WidgetKit

protocol WidgetReloadable {
    
    func reloadAllTimelines()
    
}

extension WidgetCenter: WidgetReloadable {}
