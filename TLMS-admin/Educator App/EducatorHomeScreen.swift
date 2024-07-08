//
//  EducatorHomeScreen.swift
//  TLMS-admin
//
//  Created by Priyanshu Gupta on 04/07/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct EducatorHomeScreen: View {
    @EnvironmentObject var authViewModel: UserAuthentication
    
    var body: some View {
        Text("Educator Home Screen")
        Button(action: {
            do {
                try Auth.auth().signOut()
                authViewModel.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }) {
            Text("Sign Out")
                .foregroundColor(.blue)
        }
    }

}


struct EducatorHomeScreen_Preview: PreviewProvider {
    static var previews: some View {
        EducatorHomeScreen()
    }
}
