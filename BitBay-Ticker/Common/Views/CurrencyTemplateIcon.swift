import SwiftUI

struct CurrencyTemplateIcon: View {
    
    let letter: String
    let backgroundColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
            Text(letter)
                .font(.body)
                .foregroundColor(Color.white)
        }
    }
    
}

#if DEBUG
struct CurrencyTemplateIcon_Previews: PreviewProvider {
    
    static var previews: some View {
        let letter = "A"
        let backgroundColor = Color.yellow
        
        return CurrencyTemplateIcon(letter: letter, backgroundColor: backgroundColor)
            .previewLayout(.fixed(width: 200, height: 200))
    }
    
}
#endif
