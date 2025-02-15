import SwiftUI

struct EducatorAccept: View {
    
    var educator: Educator
    @ObservedObject var firebaseFetch = FirebaseFetch()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {

        PNGImageView(imageName: "uprectange", width: 400, height: .infinity)
                .overlay{
                    VStack(alignment: .center, spacing: 10) {
                ProfileEducatorImage(imageName: educator.profileImageURL, width: .infinity, height: 200)
                        HStack {
                            VStack(alignment: .leading){
                                Text(educator.fullName)
                                    .font(.custom("Poppins-SemiBold", size: 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .dark ? Color.white: Color.black)
                                
                                
                                Text(educator.about)
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(colorScheme == .dark ? Color.white: Color.black)
                                
                                Text(educator.email)
                                    .font(.custom("Poppins-Medium", size: 16))
                                    .foregroundColor(colorScheme == .dark ? Color.white: Color.black)
                                Text(educator.phoneNumber)
                                    .font(.custom("Poppins-Medium", size: 16))
                                    .foregroundColor(colorScheme == .dark ? Color.white: Color.black)
                            }
                            
                            Spacer()
                        }
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
                    .toolbar(.hidden, for: .tabBar)
            .navigationTitle("Educator")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 80)
            .padding(.bottom, 30)
            .padding(20)
            
        }
                .ignoresSafeArea()
        .background(colorScheme == .dark ? Color.black : Color.white)
       
    }
}

#Preview {
    EducatorAccept(educator: Educator(id: "hrgsdvdbhe", firstName: "thdrgss", lastName: "htdrgsds", about: "ntrvsd", email: "nbds", password: "ntbdrvsdc", phoneNumber: "Brvseca", profileImageURL: "htrsds"))
}
