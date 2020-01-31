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
