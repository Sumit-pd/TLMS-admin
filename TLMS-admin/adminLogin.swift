//
//  adminLogin.swift
//  TLMS-admin
//
//  Created by Priyanshu Gupta on 03/07/24.
//

import Foundation
import SwiftUI

struct AdminScreen:View{
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    var body :some View{
        
            ZStack(alignment: .center) {
                Color(UIColor(named: "BackgroundColour")!).edgesIgnoringSafeArea(.all)
                VStack (spacing:30){
                    Text("Welcome To \n " + "Svadhyaya").bold().font(.largeTitle).frame(maxWidth: .infinity, maxHeight: 100 , alignment: .topLeading).padding(10)
                 
                    
                    Image("MainScreenImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                        .padding()
                    Text("Sign to your Admin Account").bold().font(.title2).frame(maxWidth: .infinity , alignment: .leading)
                    
                    VStack(spacing:20){
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
                        NavigationLink(destination: AdminHomeScreen()){
                                Text("Login").font(.title2).foregroundColor(.white).frame(maxWidth: .infinity, minHeight: 50).background(Color(UIColor(named: "PrimaryColour")!)).cornerRadius(8)
                            
                        }
                        NavigationLink(destination: ResetPassword(), label: {
                            HStack(spacing:3){
                                Text("You want to reset Passsord?").fontWeight(.bold).foregroundColor(.black)
                                Text("Reset Password").fontWeight(.bold).foregroundColor(.blue)
                                
                            }.font(.system(size: 15))
                        })
                    }
                    
                } .padding(.horizontal).frame(maxWidth: .infinity ,alignment: .top)
                
                
            }
            
            
        
    }
}


struct AdminScreen_Preview :PreviewProvider{
    static var previews: some View{
        AdminScreen()
    }
}



//    .navigationBarBackButtonHidden(true)








//
//
//struct ContentView: View {
// 
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color(.systemGray6)
//                    .ignoresSafeArea()
//
//                VStack {
//                    Image("laptop") // Replace with your actual image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 150)
//                        .padding()
//
//                    Text("Welcome to Svadhyaya")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding()
//
//                    VStack(spacing: 16) {
//                        TextField("Email", text: $email)
//                            .padding()
//                            .background(Color(.systemGray5))
//                            .cornerRadius(8)
//
//                        SecureField("Password", text: $password)
//                            .padding()
//                            .background(Color(.systemGray5))
//                            .cornerRadius(8)
//
//                        Button(action: {
//                            Auth.auth().signIn(withEmail: email, password: password) {
//                                (fire, error) in if let _ = error {
//                                    print("Couldnt log in")
//                        
//                                }
//                                print("You've successfully Logged In!!")
//                            }
////
//                            // Perform login action here
//                            showAlert = true
//                        }) {
//                            Text("Login")
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .cornerRadius(8)
//                        }
//                        .padding()
//                    }
//                    .padding(.horizontal)
//
//                    HStack {
//                        Text("Don't have an account?")
//                            .font(.headline)
//                            .foregroundColor(.blue)
//                        NavigationLink(destination: SignupView()) { // Link to signup view
//                            Text("Signup")
//                                .font(.headline)
//                                .foregroundColor(.blue)
//                        }
//                    }
//                    .padding()
//                }
//                .padding()
//            }
//            .navigationTitle("")
//            .navigationBarHidden(true)
////            .alert("Invalid Credentials", isPresented: $showAlert) {
////                Button("OK", role: .cancel) { }
////            } message: {
////                Text("Please check your email and password.")
////            }
//        }
//    }
//}
//
//struct SignupView: View { // Example signup view
//    @State private var fullName = ""
//    @State private var email = ""
//    @State private var password = ""
//
//    var body: some View {
//        VStack {
//            Text("Create Account")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//
//            VStack(spacing: 16) {
//                TextField("Full Name", text: $fullName)
//                    .padding()
//                    .background(Color(.systemGray5))
//                    .cornerRadius(8)
//
//                TextField("Email", text: $email)
//                    .padding()
//                    .background(Color(.systemGray5))
//                    .cornerRadius(8)
//
//                SecureField("Password", text: $password)
//                    .padding()
//                    .background(Color(.systemGray5))
//                    .cornerRadius(8)
//
//                Button(action: {
//                    Auth.auth().createUser(withEmail: email, password: password)
//                    // Perform signup action here
//                }) {
//                    Text("Create Account")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//                .padding()
//            }
//            .padding(.horizontal)
//
//            HStack {
//                Text("Already have an account?")
//                    .font(.headline)
//                    .foregroundColor(.blue)
//                NavigationLink(destination: ContentView()) { // Link to login view
//                    Text("Login")
//                        .font(.headline)
//                        .foregroundColor(.blue)
//                }
//            }
//            .padding()
//        }
//        .padding()
//    }
//}
//

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
