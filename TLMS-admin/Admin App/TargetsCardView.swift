import SwiftUI
import FirebaseFirestore

struct TargetsCardView: View {
    
    @State var courseService = CourseServices()
    @State var targetName: String
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    var onUpdate: () -> Void
    
    var body: some View {
        NavigationLink(destination: TabBar(target: targetName)) {
            HStack(alignment: .center) {
                Image(systemName: "circle.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(hex: "#D2CDFA")!)
                    .frame(width: 30, height: 30)
                
                Spacer()
                
                Text(targetName)
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Adjust text color for dark mode
                    .font(.custom("Poppins-Medium", size: 20))
                    .font(.title2)
                    .padding(.trailing, 10)
                
                Spacer()
                
                Button(action: {
                    let db = Firestore.firestore()
                    db.collection("Targets").document(targetName).delete { error in
                        if let error = error {
                            print("Error removing document: \(error)")
                        } else {
                            courseService.fetchTargets { error in
                                print("Error fetching targets!")
                            }
                            onUpdate()
                        }
                    }
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(colorScheme == .dark ? .white : .black) // Adjust trash icon color for dark mode
                }
                
            }
            .padding(20)
            .frame(width: 345, height: 86, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1) // Adjust stroke color for dark mode
            )
        }
    }
}

struct TargetCard_Previews: PreviewProvider {
    static var previews: some View {
        TargetsCardView(targetName: "gjgj", onUpdate: {})
    }
}
