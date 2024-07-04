import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userRole: String? = nil

    init() {
//        do {
//            try Auth.auth().signOut()
//        } catch {
//
//        }
        self.isLoggedIn = Auth.auth().currentUser != nil
        if self.isLoggedIn {
            fetchUserRole()
        }
    }

    func signIn(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                self.isLoggedIn = true
                self.fetchUserRole()
                completion(nil)
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.userRole = nil
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    private func fetchUserRole() {
        guard let user = Auth.auth().currentUser else { return }
        let userId = user.uid
        print(userId)
        let db = Firestore.firestore()
        let educatorsRef = db.collection("Learners").document(userId)
        let adminsRef = db.collection("Admins").document(userId)
        let pendingEducatorsRef = db.collection("Pending-Educators").document(userId)

        educatorsRef.getDocument { document, error in
            if let document = document, document.exists {
                self.userRole = "educator"
            } else {
                adminsRef.getDocument { document, error in
                    if let document = document, document.exists {
                        self.userRole = "admin"
                    } else {
                        pendingEducatorsRef.getDocument { document, error in
                            if let document = document, document.exists {
                                self.userRole = "pendingEducator"
                            } else {
                                print("No role found for user")
                            }
                        }
                    }
                }
            }
        }
    }
}

