import SwiftUI

struct ErrorBanner: View {
    
    let text: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "xmark.octagon.fill")
                .foregroundColor(.white)
            Text(text)
                .foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Color.red)
    }
    
}

struct ErrorBanner_Previews: PreviewProvider {
    
    static var previews: some View {
        ErrorBanner(text: "There is a problem with connection.")
    }
    
}
