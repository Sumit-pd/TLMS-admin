import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserAuthentication: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var login = false
    @Published var userRole: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn = false
    @Published var givenPasswordToAdmin : String = ""

    init() {
        checkUserStatus()
    }

    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { [self] firebaseResult, err in
            if let err = err {
                alertMessage = err.localizedDescription
                showAlert = true
                print("Not logged in")
                return
            }
            alertMessage = "You've logged in"
            showAlert = false
            login = true
            print("Logged in")
            fetchUserRole()
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.userRole = ""
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func fetchUserRole() {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        let adminRef = db.collection("Admins").document(user.uid)
        let eduRef = db.collection("Educators").document(user.uid)
        
        adminRef.getDocument { document, error in
            if let document = document, document.exists {
                if let role = document.data()?["role"] as? String, let givenPass = document.data()?["password"] as? String{
                    self.userRole = role
                    self.givenPasswordToAdmin = givenPass
                    self.isLoggedIn = true
                    print("User role: \(role)")
                }
            } else {
                eduRef.getDocument { document, error in
                    if let document = document, document.exists {
                        if let role = document.data()?["role"] as? String {
                            self.userRole = role
                            self.isLoggedIn = true
                            print("User role: \(role)")
                        }
                    } else {
                        print("Document does not exist or error fetching document: \(String(describing: error?.localizedDescription))")
                    }
                }
            }
        }
    }


    func checkUserStatus() {
        if Auth.auth().currentUser != nil {
            self.fetchUserRole()
        }
    }
}
