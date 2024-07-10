//
//  LoginScreen.swift
//  TLMS-admin
//
//  Created by Paras on 06/07/24.
//

import SwiftUI
import FirebaseAuth
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
        NavigationView {
            ZStack(alignment:. bottom) {
           
                    PNGImageView(imageName: "Waves", width: 395, height: 195)
//                        .0// Extend to ignore safe area insets
                
                

                VStack(alignment : .center, spacing: 30) {

                    
                        
                    TitleLabel(text: "Welcome To Svadhyay")
                        .padding(.top, 80)
            

                    PNGImageView(imageName: "laptop", width: 139, height: 157)
                    
                    VStack() {
                        CustomTextField(placeholder: "Email", text: $email)
                            .onChange(of: email) { _, newVal in
                                isEmailValid = validateEmail(email: newVal)
                                print(isEmailValid)
                                    
                            }
                        HStack {
                            Spacer()
                            if !isEmailValid && email != ""{
                                Text("Enter a valid email address")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                                    .padding(.trailing, 35)
                            } else {
                                Text("Enter a valid email address")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 15)
                            }
                        }
                        
                        CustomSecureField(placeholder: "Password", text: $password)

                    }
                    
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            navigateToForgotPassword = true
                        }
                        .foregroundColor(.blue)
                     
//                        .padding(.horizontal)
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .padding(.trailing ,20)

                    }
                            CustomButton(label: "Login", action: {
                                userAuth.email = email
                                userAuth.password = password
                                userAuth.loginUser()
                            })
                        
                        
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Login Action"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                        
                        // Sign Up Option
                        HStack {
                            Text("Register as Educator?")
                                .font(.system(size: 15, weight: .regular, design: .default))
                            NavigationLink(destination: CreateAccountView()) {
                                Text("Sign Up")
                                    .font(.system(size: 15, weight: .bold, design: .default))
                                    .fontWeight(.bold)
//                                CustomButton(label: "SignUp", action: {})
                            }
                            NavigationLink(destination : ForgotPasswordView(), isActive: $navigateToForgotPassword) {
                                EmptyView()
                            }
                            
                        }
            Spacer()
                    }
                }
            .ignoresSafeArea()
            }
        
        }
    }
    
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
