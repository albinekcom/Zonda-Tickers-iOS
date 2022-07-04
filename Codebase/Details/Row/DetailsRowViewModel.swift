struct DetailsRowViewModel: Identifiable, Equatable {
    
    var id: String { title }
    
    let title: String
    
    let valueString: String
    let valueStringColorStyle: StringColorStyle
    
}
