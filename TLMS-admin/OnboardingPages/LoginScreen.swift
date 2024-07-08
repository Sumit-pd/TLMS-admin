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
            ZStack(alignment:. bottom) {
           
                    PNGImageView(imageName: "Waves", width: 395, height: 195)
//                        .position(x:195,y:735)// Extend to ignore safe area insets
                
                
                VStack(alignment : .center, spacing: 20) {
                    
                        
                    TitleLabel(text: "Welcome To Svadhyay")
                        .padding(.top, 80)
            
                    PNGImageView(imageName: "laptop", width: 139, height: 187)
                    
                    VStack(spacing: 20) {
                        CustomTextField(placeholder: "Email", text: $email)
                        
                        CustomSecureField(placeholder: "Password", text: $password)
                        
                    }
                            CustomButton(label: "Login", action: {
                                userAuth.email = email
                                userAuth.password = password
                                userAuth.loginUser()
                            })
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
            Spacer()
                    }
                }
            .ignoresSafeArea()
            }
        
        }
    }
    
    
//    var body: some View {
//        
//        ZStack(alignment: .bottom){
//            
//            PNGImageView(imageName: "Waves", width: 395.0, height: 195.0)
//
//            VStack(alignment : .center ,spacing: 30){
//                
//                    TitleLabel(text: "Welcome To Swadhyay")
//                    .padding(.top ,80)
//                    PNGImageView(imageName: "MainScreenImage", width: 139, height: 107)
//
//                    VStack(spacing: 20) {
//                        HeadingLabel(text: "Sign to your Admin Account")
//                        CustomTextField(placeholder: "Email", text: $email)
//                        CustomSecureField(placeholder: "Enter password", text: $password, placeholderOpacity: 0.3)
//                    }
//
//                CustomButton(label: "Login" , action: {
//                    userAuth.email = email
//                    userAuth.password = password
//                    userAuth.loginUser()
//                })
//                    
//                   Spacer()
//            }.padding(20)
//            
//               
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//                }
//            
//        }
//        .ignoresSafeArea()
//
//            
//    }
//}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
