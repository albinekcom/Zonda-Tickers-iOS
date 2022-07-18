import SwiftUI

struct PlaceholderView: View {
    
    let count: Int
    let isCircleVisible: Bool
    let isSimpleTitle: Bool
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ForEach(1...count, id: \.self) { _ in
                    placeholderRow(isSimpleTitle: isSimpleTitle)
                        .frame(height: proxy.size.height / CGFloat(count))
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func placeholderRow(isSimpleTitle: Bool) -> some View {
        HStack {
            HStack {
                if isCircleVisible {
                    Circle()
                        .fill(.secondary)
                        .frame(maxWidth: 32, maxHeight: 32)
                }
                
                if isSimpleTitle {
                    VStack(alignment: .leading, spacing: 4) {
                        placeholderTitle
                    }
                } else {
                    HStack(alignment: .top, spacing: 4) {
                        placeholderTitle
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("-")
                    .font(.headline)
                HStack(spacing: 4) {
                    Text("-")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var placeholderTitle: some View {
        Group {
            Text("-")
                .font(.headline)
            Text("\\ -")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    
}
