//
//  FirstTimeLogin.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//

import SwiftUI
import FirebaseAuth

struct FirstTimeLogin: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var newpassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var errorMessage: String?
    var body: some View {
        ZStack(alignment: .bottom){
            
            PNGImageView(imageName: "Waves", width: 395.0, height: 195.0)

            VStack(alignment : .center ,spacing: 30){
                
                    TitleLabel(text: "Create New Password")
                    .padding(.top ,80)
                    PNGImageView(imageName: "MainScreenImage", width: 139, height: 107)

                    VStack(spacing: 20) {
                        
                        CustomSecureField(placeholder: "New Password", text: $newpassword, placeholderOpacity: 0.3)
                        CustomSecureField(placeholder: "Confirm Password", text: $confirmPassword, placeholderOpacity: 0.3)
                    }

                CustomButton(label: "Create", action: {navigateBackToLogin()})
                
                   Spacer()
            }.padding(20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                }
            
        }
        .ignoresSafeArea()
    }
    
    func navigateBackToLogin() {
        if newpassword == confirmPassword {
            let user = Auth.auth().currentUser
            user?.updatePassword(to: confirmPassword)
            presentationMode.wrappedValue.dismiss()
            print("Password Changed")
        } else {
            print("Pssword do not match")
            errorMessage = "Passwords Do not match"
            showAlert = true
        }
    }
}

#Preview {
    FirstTimeLogin()
}
