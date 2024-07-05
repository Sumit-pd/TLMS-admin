//
//  HomeAdminScreen.swift
//  TLMS-admin
//
//  Created by Priyanshu Gupta on 04/07/24.
//

import Foundation
import FirebaseAuth
import SwiftUI

struct AdminHomeScreen: View {
    var body: some View {
        VStack {
            Text("Admin Home Screen")
                .navigationBarBackButtonHidden()
            NavigationLink(destination : MainView()) {
                Button(action : {
                    print("Button")
                    do {
                        try Auth.auth().signOut()
                        
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                    
                }) {
                    Text("Sign Out")
                        .foregroundColor(.blue)
                }
                .padding(.top, 200)
            }
        }
        
    }

}


struct AdminHomeScreen_Preview: PreviewProvider {
    static var previews: some View {
        TargetScreen()
    }
}
