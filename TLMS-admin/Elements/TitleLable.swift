import SwiftUI

// Custom TitleLabel struct
struct TitleLabel: View {
    var text: String
    var fontSize: CGFloat = 34 // Default font size

    var body: some View {
        
        Text(text)
            .lineLimit(nil)
                        
            .frame(alignment: .leading)
            .ignoresSafeArea()
//            .padding(.top, 0)
//            .position(CGPoint(x: 65.0, y: -25.0))
            .font(.custom("Poppins-Bold", size: 34))
            .foregroundColor(.black)
            .frame(maxWidth: 400, alignment: .leading) // Optional: Full width alignment
            .background(Color.clear) // Optional: Background color
            .padding(.leading, 5)
//            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
