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

#if DEBUG
struct ErrorBanner_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ErrorBanner(text: "There is a problem with connection.")
                .previewLayout(.fixed(width: 400, height: 70))
                .environment(\.colorScheme, .light)
            ErrorBanner(text: "There is a problem with connection.")
                .previewLayout(.fixed(width: 400, height: 70))
                .environment(\.colorScheme, .dark)
        }
    }
    
}
#endif
