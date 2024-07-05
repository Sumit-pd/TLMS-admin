//
//  CreateEducatorAccount.swift
//  TLMS-admin
//
//  Created by Priyanshu Gupta on 04/07/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct NavigationHelper: View {
    var destination: AnyView

    var body: some View {
        NavigationLink(destination: destination, isActive: .constant(true)) {
            EmptyView()
        }
    }
}

struct CreateAccount:View{
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToPendingScreen = false
    
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
                        
                        Button(action: {
                            uploadPendingEducatorDetails()
                        }) {
                            Text("Create Account")
                        }
                        
                        if navigateToPendingScreen {
                            NavigationHelper(destination: AnyView(PendingEducatorScreen()))
                        }
                        
                    } .padding(.horizontal).frame(maxWidth: .infinity ,alignment: .top)
                    
                    
                }.padding(.horizontal).padding(.top ,20)
                
                
            }
    }
    
    func uploadPendingEducatorDetails() {
        let datadict = ["Name" : fullName,
                       "Email" : email,
                       "Password" : password,
                        "role" : "Pending-Educator"
                      ]
        let db = Firestore.firestore()
        db.collection("Pending-Educators").addDocument(data: datadict) { error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                alertMessage = "Awesome! Account approval request sent."
                showAlert = true
                navigateToPendingScreen = true
            }
        }
    }
    
}


struct CreateAccount_preview:
    PreviewProvider{
    static var previews: some View{
        CreateAccount()
    }
}


