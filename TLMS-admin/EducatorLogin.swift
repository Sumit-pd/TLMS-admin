//
//  educatorLogin.swift
//  TLMS-admin
//
//  Created by Priyanshu Gupta on 03/07/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct EducatorScreen:View{
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var errorMessage: String?
    
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
                    Text("Sign to your Educator Account").bold().font(.title2).frame(maxWidth: .infinity , alignment: .leading)
                    
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
                    
                            NavigationLink(destination: EducatorHomeScreen()){
                                Button(action : {
                                    print("Button Action")
                                    Auth.auth().signIn(withEmail: email, password: password) {
                                        _, error in if let _ = error {
                                            print("Error Logging In")
                                        }
                                        else {
                                            errorMessage = "You've successfully logged in"
                                            showAlert = true
                                        }
                                    }
                                }) {
                                    Text("Login")
                                        .font(.title3)
                                        .foregroundColor(.blue)
                                        .background()
                                }
                                
                            }
                            NavigationLink(destination: CreateAccount(), label: {
                                HStack(spacing:3){
                                    Text("Don't have an Account?")
                                    Text("Register Account").fontWeight(.bold)
                                    
                                }.font(.system(size: 15))
                            })
                        
                    }
                    
                } .padding(.horizontal).frame(maxWidth: .infinity ,alignment: .top)
                
                
            }.padding(.horizontal)
            
            
        
    }
}


struct EducatorScreen_Preview :PreviewProvider{
    static var previews: some View{
        EducatorScreen()
    }
}
