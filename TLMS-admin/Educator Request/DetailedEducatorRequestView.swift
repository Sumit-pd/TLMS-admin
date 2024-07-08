import SwiftUI

struct DetailedEducatorRequestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    var educator : Educator
    
    @State private var profileImage: Image? = Image(systemName: "person.circle.fill")
    @State private var name: String = ""
    @State private var about: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""

    var body: some View {
        VStack {
            // Profile Picture
            profileImage?
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .padding()
                .onTapGesture {
                    // Implement image picker logic here
                }
                Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Name:")
                            .font(.headline)
                        InfoFieldViews(text: educator.EducatorName)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("About:")
                            .font(.headline)
                        InfoFieldViews(text: educator.about)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Phone Number:")
                            .font(.headline)
                        InfoFieldViews(text: educator.phoneNumber)
                    }
                    VStack(alignment: .leading) {
                        Text("Email:")
                            .font(.headline)
                        InfoFieldViews(text: educator.email)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            
            // Approval and Rejection Buttons
            HStack(spacing: 20) {
                RequestsButton(text: "Approve", action: {
                    firebaseFetch.moveEducatorToApproved(educator: educator)
                    presentationMode.wrappedValue.dismiss()
                })

                RequestsButton(text: "Reject", action: {
                    firebaseFetch.removeEducator(educator: educator)
                    presentationMode.wrappedValue.dismiss()
                })
            }
            .padding(.bottom)
        }
        .padding()
    }
}

struct EducatorProfileApprovalView_Previews: PreviewProvider {
    static var previews: some View {
        let educator = Educator(EducatorName: "Veronica", about: "Hey Noobies, Coding isn't your thing!", email: "veronica@gmail.com", password: "123456", phoneNumber: "9898090909", profileImageURL: "ProfileURL"
        )
        DetailedEducatorRequestView(educator: educator)
    }
}

struct InfoFieldViews : View {
    var text : String
    
    var body : some View {
        Text(text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}

struct RequestsButton : View{
    var text : String
    var action : () -> Void
    
    var body : some View {
        
        Button(action : action) {
            Text(text)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}
