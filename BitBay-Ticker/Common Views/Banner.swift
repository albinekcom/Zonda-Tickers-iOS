import SwiftUI

struct Banner: View {
    
    let text: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(text)
                .foregroundColor(.white)
        }
        .background(Color.red)
        
    }
    
}

struct Banner_Previews: PreviewProvider {
    
    static var previews: some View {
        Banner(text: "There is a problem with connection.")
            
    }
    
}
