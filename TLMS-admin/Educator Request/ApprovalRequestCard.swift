import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ApprovalRequestCard: View {
    var educator: Educator
    
    var body: some View {
        NavigationLink(destination: DetailedEducatorRequestView(educator: educator)) {
            HStack(alignment: .center, spacing: 16) {
                
                ProfileCircleImage(imageURL: educator.profileImageURL, width: 60, height: 60)
     
                VStack(alignment: .leading, spacing: 5) {
                    HeadlineText(text1: educator.firstName + educator.lastName)
                    SubHeadlineText(text2: educator.about)
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal, 5)
        }
    }
}

struct EducatorCardView_Previews: PreviewProvider {
    static var previews: some View {
        let educator = Educator(
            firstName: "Dummy",lastName: "User", about: "Beware of my presence, Coders!", email: "veronica@gmail.com", password: "1234567", phoneNumber: "7878787878", profileImageURL: "fhgfgd"
        )
        ApprovalRequestCard(educator: educator)
    }
}
