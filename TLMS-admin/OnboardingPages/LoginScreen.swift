import SwiftUI
import FirebaseAuth

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var login = false
    @State private var navigateToForgotPassword = false
    @State private var isEmailValid = false
    @EnvironmentObject var userAuth: UserAuthentication
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("Waves")
                .resizable()
                .scaledToFit()
                .frame(width: 395, height: 195)
            
            VStack(alignment: .center, spacing: 30) {
                Text("Welcome \nTo Svadhyay")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 80)
                    .foregroundColor(Color.primary)
                
                Image("laptop")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 139, height: 157)
                
                VStack() {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .onChange(of: email) { _, newVal in
                            isEmailValid = validateEmail(email: newVal)
                        }
                    
                    HStack {
                        Spacer()
                        if !isEmailValid && email != "" {
                            Text("Enter a valid email address")
                                .font(.caption2)
                                .foregroundColor(.red)
                                .padding(.trailing, 35)
                        } else {
                            Text("Enter a valid email address")
                                .font(.caption2)
                                .foregroundColor(.clear)
                                .padding(.trailing, 15)
                        }
                    }
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                }
                
                HStack {
                    Spacer()
                    Button("Forgot Password?") {
                        navigateToForgotPassword = true
                    }
                    .foregroundColor(.blue)
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .padding(.trailing, 20)
                }
                
                Button(action: {
                    userAuth.email = email
                    userAuth.password = password
                    userAuth.loginUser()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Action"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                HStack {
                    Text("Register as Educator?")
                        .font(.system(size: 15, weight: .regular, design: .default))
                    
                    NavigationLink(destination: CreateAccountView()) {
                        Text("Sign Up")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .fontWeight(.bold)
                    }
                    
                    NavigationLink(destination: ForgotPasswordView(), isActive: $navigateToForgotPassword) {
                        EmptyView()
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .environmentObject(UserAuthentication())
            .preferredColorScheme(.dark) // Preview in dark mode
        LoginScreen()
            .environmentObject(UserAuthentication())
            .preferredColorScheme(.light) // Preview in light mode
    }
}

