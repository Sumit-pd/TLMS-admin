//
//  CheckUserRole.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//

import Foundation
import SwiftUI

struct CheckUserRole: View {
    @EnvironmentObject var userAuth: UserAuthentication

    var body: some View {
        Group {
            if userAuth.isLoggedIn {
                if userAuth.userRole == "admin" {
                    if userAuth.password == userAuth.givenPasswordToAdmin {
                        FirstTimeLogin()
                    } else {
                        TargetScreen()
                    }
                } else if userAuth.userRole == "educator" {
                    EducatorHomeScreen()
                } else {
                    Text("Unknown role")
                }
            } else {
                LoginScreen()
            }
        }
        .alert(isPresented: $userAuth.showAlert) {
            Alert(title: Text("Error"), message: Text(userAuth.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckUserRole_Previews: PreviewProvider {
    static var previews: some View {
        CheckUserRole().environmentObject(UserAuthentication())
    }
}
