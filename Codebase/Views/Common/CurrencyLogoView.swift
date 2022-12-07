import SwiftUI

struct CurrencyLogoView: View {
    
    let currencyId: String?
    
    var body: some View {
        if let currencyId = currencyId, let _ = UIImage(named: currencyId) {
            Image(currencyId)
                .resizable()
        } else {
            currencyLetterLogo(currencyId: currencyId)
        }
    }
    
    private func currencyLetterLogo(currencyId: String?) -> some View {
        ZStack {
            Circle()
                .fill(currencyId.generatedBackgroundColor)
            Text(currencyId.firstCharacter.uppercased())
                .font(.headline)
                .foregroundColor(currencyId.generatedForegroundColor)
        }
    }
    
}

#if DEBUG && !TESTING

struct CurrencyLogo_Previews: PreviewProvider {

    static var previews: some View {
        CurrencyLogoView(currencyId: "btc")
        CurrencyLogoView(currencyId: "unknown")
    }

}

#endif
