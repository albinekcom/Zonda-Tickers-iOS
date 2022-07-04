import SwiftUI

struct DetailsRow: View {
    
    let viewModel: DetailsRowViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.title.localized)
                .font(.callout)
            Spacer()
            Text(viewModel.valueString)
                .font(.body)
                .foregroundColor(viewModel.valueStringColorStyle.color)
        }
        .animation(.default, value: viewModel.valueString)
        .accessibility(label: Text(viewModel.title))
        .accessibility(value: Text(viewModel.valueString))
    }
    
}

#if DEBUG

struct DetailsRow_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailsRow(viewModel: .init(title: "Title",
                                    valueString: "Value",
                                    valueStringColorStyle: .normal))
    }
    
}

#endif
