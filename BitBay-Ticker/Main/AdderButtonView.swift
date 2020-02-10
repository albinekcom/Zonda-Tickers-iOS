import SwiftUI

struct AdderButtonView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "plus")
                .font(Font.system(size: 22, weight: .light))
            Spacer()
        }
        .accessibility(label: Text("Add"))
    }
    
}

#if DEBUG
struct AdderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AdderButtonView()
    }
}
#endif
