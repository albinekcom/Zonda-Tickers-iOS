import SwiftUI

struct AdderSearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: .magnifyingGlass)
                .foregroundColor(.secondary)
            TextField("Search", text: $searchText)
                .foregroundColor(.primary)
                .disableAutocorrection(true)
            Spacer()
            Image(systemName: .multiplyCircleFill)
                .foregroundColor(.secondary)
                .opacity(searchText == "" ? 0 : 1)
                .onTapGesture { searchText = "" }
        }
        .padding(8)
        .padding(.horizontal, 4)
        .background(Color(.quaternaryLabel))
        .cornerRadius(8)
    }
    
}

#if DEBUG

struct AdderSearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        AdderSearchBarView(searchText: .constant(""))
        AdderSearchBarView(searchText: .constant("Some text"))
    }
    
}

#endif
