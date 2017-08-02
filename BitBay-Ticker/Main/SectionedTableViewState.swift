import Foundation

enum TableViewEditingCommand {
    case MoveItem(sourceIndex: IndexPath, destinationIndex: IndexPath)
    case DeleteItem(IndexPath)
}

struct SectionedTableViewState {
    
    var sections: [SectionOfTickerViewModel]
    
    init(sections: [SectionOfTickerViewModel]) {
        self.sections = sections
    }
    
    func execute(command: TableViewEditingCommand) -> SectionedTableViewState {
        switch command {
        case .DeleteItem(let indexPath):
            var sections = self.sections
            var items = sections[indexPath.section].items
            items.remove(at: indexPath.row)
            TickerStore.shared.removeTicker(at: indexPath.row)
            sections[indexPath.section] = SectionOfTickerViewModel(original: sections[indexPath.section], items: items)
            return SectionedTableViewState(sections: sections)
        case .MoveItem(let moveEvent):
            var sections = self.sections
            var sourceItems = sections[moveEvent.sourceIndex.section].items
            var destinationItems = sections[moveEvent.destinationIndex.section].items
            
            TickerStore.shared.swap(sourceRow: moveEvent.sourceIndex.row, destinationRow: moveEvent.destinationIndex.row)
            
            if moveEvent.sourceIndex.section == moveEvent.destinationIndex.section {
                destinationItems.insert(destinationItems.remove(at: moveEvent.sourceIndex.row),
                                        at: moveEvent.destinationIndex.row)
                let destinationSection = SectionOfTickerViewModel(original: sections[moveEvent.destinationIndex.section], items: destinationItems)
                sections[moveEvent.sourceIndex.section] = destinationSection
                
                return SectionedTableViewState(sections: sections)
            } else {
                let item = sourceItems.remove(at: moveEvent.sourceIndex.row)
                destinationItems.insert(item, at: moveEvent.destinationIndex.row)
                let sourceSection = SectionOfTickerViewModel(original: sections[moveEvent.sourceIndex.section], items: sourceItems)
                let destinationSection = SectionOfTickerViewModel(original: sections[moveEvent.destinationIndex.section], items: destinationItems)
                sections[moveEvent.sourceIndex.section] = sourceSection
                sections[moveEvent.destinationIndex.section] = destinationSection
                
                return SectionedTableViewState(sections: sections)
            }
        }
    }
    
}
