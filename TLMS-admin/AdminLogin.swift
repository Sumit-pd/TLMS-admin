import Foundation
import SwiftUI
import FirebaseAuth

struct AdminScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var isLoggedIn = false
    @State private var errorMessage: String?
    @State private var inputText: String = ""
    @State private var newpassword: String = ""
    var body: some View {
        ZStack(alignment: .center) {
            Color(UIColor(named: "BackgroundColour")!).edgesIgnoringSafeArea(.all)
            VStack{
                TitleLabel(text: "Welcome To "  + "Swadhyay")
                VStack(spacing: 30) {
                    
                    
                    PNGImageView(imageName: "MainScreenImage", width: 139, height: 107)
                    
                    HeadingLabel(text: "Sign to your Admin Account")
                    
                    VStack(spacing: 20) {
                        CustomTextField(placeholder: "Email", text: $inputText)
                        
                        CustomSecureField(placeholder: "Enter password", text: $newpassword, placeholderOpacity: 0.3)
                    }
                    
                    
                    CustomButton(label: "Login") {
                        print("Button Pressed!")
                    }
                    
                    
                    .navigationBarBackButtonHidden()
                    
                }
                
                .padding()
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                }
            }.padding(.top, -150)
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, err in
            if let err = err {
                errorMessage = err.localizedDescription
                showAlert = true
                return
            }
            // Navigate to AdminHomeScreen if login is successful
            isLoggedIn = true
        }
    }
}

struct AdminScreen_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView { 
            AdminScreen()
        }
    }
}


