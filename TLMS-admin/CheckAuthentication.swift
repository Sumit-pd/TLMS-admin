//
//  CheckAuthentication.swift
//  TLMS-admin
//
//  Created by Abcom on 05/07/24.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userRole: String? = nil

    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        fetchUserRole()
    }

    func signIn(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                self.isLoggedIn = true
                completion(nil)
            }
        }
    }
    
    private func fetchUserRole() {
            guard let user = Auth.auth().currentUser else { return }
            let userId = user.uid
            // Assume we have a "users" collection where each user document has a "role" field
            Firestore.firestore().collection("users").document(userId).getDocument { document, error in
                if let document = document, document.exists {
                    self.userRole = document.get("role") as? String
                } else {
                    print("Document does not exist")
                }
            }
        }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

