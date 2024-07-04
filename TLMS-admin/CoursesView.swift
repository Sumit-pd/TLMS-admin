import SwiftUI

struct CoursesView: View {
    @State private var selectedDomain = "GD, PI & WAT for CAT & OMTs"
    @State private var showModal = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    // GeometryReader to position the "No Courses" text
                    GeometryReader { geometry in
                        VStack {
                            Text("No Courses")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color(hex: "#6C5DD4").opacity(0.5))
                                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.4)
                        }
                    }
                }
                .padding(.horizontal)

                // Background Image
                Image("homescreenWave")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.bottom) // Extend to the bottom edge
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showModal.toggle()
                    }) {
                        HStack {
                            Text(selectedDomain)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action for plus button
                        print("Plus button tapped")
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 15)) // Set the button font size to 15
                            .fontWeight(.bold)
                    }
                }
            }
            .navigationBarHidden(false)
            .edgesIgnoringSafeArea(.bottom) // Ensure content extends behind tab bar
            .sheet(isPresented: $showModal) {
                DomainSelectionView(selectedDomain: $selectedDomain, showModal: $showModal)
                    .presentationDetents([.height(200)]) // Adjust the height based on the content
            }
        }
    }
}

struct DomainSelectionView: View {
    @Binding var selectedDomain: String
    @Binding var showModal: Bool

    var body: some View {
        VStack {
            Button(action: {
                selectedDomain = "GD, PI & WAT for CAT & OMTs"
                showModal.toggle()
            }) {
                Text("GD, PI & WAT for CAT & OMTs")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
            Button(action: {
                selectedDomain = "Another Domain"
                showModal.toggle()
            }) {
                Text("Another Domain")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
            Button(action: {
                selectedDomain = "Yet Another Domain"
                showModal.toggle()
            }) {
                Text("Yet Another Domain")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

extension Color {
    init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b) // Initialize color without opacity
    }
}

#Preview {
    CoursesView()
}
