import SwiftUI

extension String {
    
    var generatedBackgroundColor: Color {
        let charactersSum = Int(unicodeScalars.map { UInt32.init($0) }.reduce(0, +))
        
        var randomNumberGenerator = RandomNumberGeneratorWithSeed(seed: charactersSum)
        
        return .init(
            red: randomColorComponentValue(using: &randomNumberGenerator),
            green: randomColorComponentValue(using: &randomNumberGenerator),
            blue: randomColorComponentValue(using: &randomNumberGenerator)
        )
    }
    
    var generatedForegroundColor: Color { .white }
    
    private func randomColorComponentValue(
        using generator: inout RandomNumberGeneratorWithSeed,
        maximumColorComponentValue: Double = 0.7
    ) -> Double {
        .random(
            in: 0...maximumColorComponentValue,
            using: &generator
        )
    }
    
}

extension Optional where Wrapped == String {
    
    var generatedBackgroundColor: Color {
        self?.generatedBackgroundColor ?? .gray
    }
    
    var generatedForegroundColor: Color {
        self?.generatedForegroundColor ?? .gray
    }
    
}

private struct RandomNumberGeneratorWithSeed: RandomNumberGenerator {
    
    init(seed: Int = 0) {
        srand48(seed)
    }
    
    func next() -> UInt64 {
        .init(Double(UInt64.max) * drand48())
    }
    
}
