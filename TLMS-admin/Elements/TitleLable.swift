import SwiftUI

// Custom TitleLabel struct
struct TitleLabel: View {
    var text: String
    var fontSize: CGFloat = 34 // Default font size

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .bold))
            .padding()
            .frame(maxWidth: 350, alignment: .leading) // Optional: Full width alignment
            .background(Color.clear) // Optional: Background color
            .padding(.leading, 0)
            .padding(.top, 40)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
