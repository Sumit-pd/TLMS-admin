import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AdminScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var isLoggedIn = false
    @State private var errorMessage: String?

    var body: some View {
        ZStack(alignment: .center) {
            Color(UIColor(named: "BackgroundColour")!).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Welcome To \n " + "Svadhyaya")
                    .bold()
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
                    .padding(10)

                Image("MainScreenImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
                    .padding()

                Text("Sign to your Admin Account")
                    .bold()
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }

                VStack {
                    Button(action: login) {
                        Text("Login")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(UIColor(named: "PrimaryColour")!))
                            .cornerRadius(8)
                    }

                    NavigationLink(destination: TargetScreen(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    
//                    .navigationBarBackButtonHidden()
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .top)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, err in
            if let err = err {
                errorMessage = err.localizedDescription
                showAlert = true
                return
            }
            isLoggedIn = true
            
        }    }
}


struct AdminScreen_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView { 
            AdminScreen()
        }
    }
}


