import SwiftUI

struct EducatorAccept: View {
    
    var educator: Educator
    @ObservedObject var firebaseFetch = FirebaseFetch()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            PNGImageView(imageName: "uprectange", width: .infinity, height: .infinity)
            VStack(alignment: .leading, spacing: 10) {
                CoursethumbnailImage(imageURL: educator.profileImageURL, width: 60, height: 60)
                Text(educator.fullName)
                    .font(.custom("Poppins-SemiBold", size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                
                Text(educator.about)
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)

                Text(educator.email)
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                Text(educator.phoneNumber)
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)

                Spacer()
                
                HStack(alignment: .center) {
                    Button(action: {
                        firebaseFetch.removeEducator(educator: educator)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Deny")
                            .frame(width: 168, height: 51)
                            .background(Color(hex: "#6C5DD4"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.custom("Poppins-Medium", size: 17.0))
                            .fontWeight(.semibold)
                    }
                    
                    Button(action: {
                        firebaseFetch.moveEducatorToApproved(educator: educator)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Accept")
                            .frame(width: 168, height: 51)
                            .background(Color(hex: "#6C5DD4"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.custom("Poppins-Medium", size: 17.0))
                            .fontWeight(.semibold)
                    }
                }
            }
            .navigationTitle("Educator")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 100)
            .padding(.bottom, 30)
            .padding(20)
        }
        .frame(width: .infinity, height: .infinity)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    EducatorAccept(educator: Educator(id: "hrgsdvdbhe", firstName: "thdrgss", lastName: "htdrgsds", about: "ntrvsd", email: "nbds", password: "ntbdrvsdc", phoneNumber: "Brvseca", profileImageURL: "htrsds"))
}
