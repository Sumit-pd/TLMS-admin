//
//  CreateEducatorAccount.swift
//  TLMS-admin
//
//  Created by Priyanshu Gupta on 04/07/24.
//

import Foundation
import SwiftUI

struct CreateAccount:View{
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
        var body :some View{
            
            NavigationView{
                ZStack(alignment: .topLeading) {
               
                    Color(UIColor(named: "BackgroundColour")!).edgesIgnoringSafeArea(.all)
                    VStack (spacing:40){
                        Text("Welcome To \n " + "Svadhyaya").bold().font(.largeTitle).frame(maxWidth: .infinity, maxHeight: 100 , alignment: .topLeading)
                     
                        Image("MainScreenImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 180)
                            .padding(.horizontal
                            )
                        Text("Create Account").bold().font(.title2).frame(maxWidth: .infinity , alignment: .center)
                        
                        VStack(spacing:10){
                            TextField("Full Name", text: $fullName )
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                            TextField("Email", text: $email)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(8)

                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                        }
                        
                        NavigationLink(destination: EducatorScreen()){
                                    Text("Create Account").font(.title2).foregroundColor(.white).frame(maxWidth: .infinity, minHeight: 50).background(Color(UIColor(named: "PrimaryColour")!)).cornerRadius(8)
                                
                        }.padding(.top , 30)
                        
                    } .padding(.horizontal).frame(maxWidth: .infinity ,alignment: .top)
                    
                    
                }.padding(.horizontal).padding(.top ,20)
                
                
            }
    }
    
}


struct CreateAccount_preview:
    PreviewProvider{
    static var previews: some View{
        CreateAccount()
    }
}



