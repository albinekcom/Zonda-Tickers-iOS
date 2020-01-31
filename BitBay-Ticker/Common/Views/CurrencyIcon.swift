import SwiftUI

struct CurrencyIcon: View {
    
    let currencyName: String
    
    var body: some View {
        image(named: currencyName)
    }
    
    private func image(named: String) -> some View {
        Group {
            if UIImage(named: named) != nil {
                Image(uiImage: UIImage(named: named)!)
                    .resizable()
            } else if named.first != nil {
                CurrencyTemplateIcon(letter: String(named.first!), backgroundColor: Color(named.color))
            } else {
                Text("")
            }
        }
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
