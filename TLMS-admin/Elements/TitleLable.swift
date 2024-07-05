import SwiftUI

// Custom TitleLabel struct
struct TitleLabel: View {
    var text: String
    var fontSize: CGFloat = 34 // Default font size

    var body: some View {
        
        Text(text)
            .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
            .frame(alignment: .leading)
            .ignoresSafeArea()
            .padding(.top, 0)
            .font(.custom("Poppins-Bold", size: 40))            
            .foregroundColor(.black)
            .frame(maxWidth: 400, alignment: .leading) // Optional: Full width alignment
            .background(Color.clear) // Optional: Background color
            .padding(.leading, 5)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
