import SwiftUI

struct CurrencyIcon: View {
    
    let currencyName: String
    
    static let size: CGFloat = 28
    
    var body: some View {
        Group {
            if UIImage(named: currencyName) != nil {
                Image(uiImage: UIImage(named: currencyName)!)
                    .resizable()
            } else if currencyName.first != nil {
                CurrencyTemplateIcon(letter: String(currencyName.first!), backgroundColor: Color(currencyName.color))
            } else {
                Text("")
            }
        }
        .frame(width: CurrencyIcon.size, height: CurrencyIcon.size)
    }
    
}

#if DEBUG
struct CurrencyIcon_Previews: PreviewProvider {
    
    static var previews: some View {
        let currencyName = "BTC"
        
        return CurrencyIcon(currencyName: currencyName)
            .previewLayout(.fixed(width: 200, height: 200))
    }
    
}
#endif
