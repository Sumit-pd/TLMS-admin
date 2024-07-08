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
    @EnvironmentObject var userAuth: UserAuthentication
    
    var body: some View {
        NavigationView {
            ZStack(alignment:.topLeading) {
                Color("#FFFFFF")
                    .edgesIgnoringSafeArea(.all)
           
                    PNGImageView(imageName: "Waves", width: 394, height: 194)
                        .position(x:195,y:735)// Extend to ignore safe area insets
                
                
                VStack(spacing: 20) {
                    
                        
                    TitleLabel(text: "Welcome To \n Svadhyay", fontSize: 20)
                    

            
                    PNGImageView(imageName: "laptop", width: 214, height: 166)
                    
                    
                    // Login Form
                    VStack(spacing: 20) {
                      CustomTextField(placeholder: "Email", text: $email)
                          
                            

                        
                     CustomSecureField(placeholder: "Password", text: $password)
                        
                        HStack {
                            Spacer()
                            Button("Forgot Password?") {
                                // Implement forgot password logic here
                            }
                            .foregroundColor(.blue)
                         
                            .padding(.horizontal)
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .padding(.trailing ,20)
    
                        }
                        
                        VStack{
                            Button(action : {
                                userAuth.email = email
                                userAuth.password = password
                                userAuth.loginUser()
                            }) {
                                Text("Login")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        }
                        
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
                        }
                        
                        // Social Login Buttons
                        HStack(spacing: 20) {
                            Button(action: {
                                // Perform Apple login action
                                print("Google login")
                            }) {
                                PNGImageView(imageName: "Google", width: 50, height: 50)
                            }
                            
                            Button(action: {
                                // Perform Apple login action
                                print("Apple login")
                            }) {
                                PNGImageView(imageName: "Apple", width: 50, height: 50)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .navigationBarHidden(true)
                }
                .padding(.top, 40)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
