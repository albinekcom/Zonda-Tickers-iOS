import SwiftUI

struct CurrencyIcon: View {
    
    let currencyName: String
    
    var body: some View {
        Image("BAT")
            .resizable()
    }
    
    private func image(named: String) -> Image {
        if let image = UIImage(named: named) {
            return Image(uiImage: image)
        } else {
            return Image(uiImage: UIImage(named: "BTC")!)
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
