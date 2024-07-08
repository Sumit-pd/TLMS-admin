import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
class FirebaseFetch: ObservableObject {
    @Published public var pendingEducators: [Educator] = []

    init() {
        fetchPendingEducators()
    }
    
    func fetchPendingEducators() {
        let db = Firestore.firestore()
        
        db.collection("Pending-Educators").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching pending educators: \(error.localizedDescription)")
            } else {
                self.pendingEducators = querySnapshot?.documents.compactMap { doc in
                    let data = doc.data()
                    return Educator(id : doc.documentID,
                                    firstName: data["FirstName"] as? String ?? "",
                                    lastName: data["LastName"] as? String ?? "",
                                    about: data["about"] as? String ?? "",
                                    email: data["email"] as? String ?? "",
                                    password: data["password"] as? String ?? "",
                                    phoneNumber: data["phoneNumber"] as? String ?? "",
                                    profileImageURL: data["profileImageURL"] as? String ?? ""
                    )
                } ?? []
            }
            
        }
    }
    
    func removeEducator(educator: Educator) {
            let db = Firestore.firestore()
            db.collection("Pending-Educators").document(educator.email).delete() { error in
                if let error = error {
                    print("Error removing document: \(error)")
                } else {
                    self.fetchPendingEducators()
                }
            }
        }
        
    func moveEducatorToApproved(educator: Educator) {
        let db = Firestore.firestore()
        let educatorData: [String: Any] = [
            "FirstName": educator.firstName,
            "LastName": educator.lastName,
            "about": educator.about,
            "email": educator.email,
            "password": educator.password,
            "phoneNumber": educator.phoneNumber,
            "profileImageURL": educator.profileImageURL,
            "role" : "educator"
        ]
        
        Auth.auth().createUser(withEmail: educator.email, password: educator.password) {
            authRes, error in if let _ = error {
                print("Error Creating a User. (Moving from Pending Educator to Educator Collection)")
            } else {
                guard let uid = authRes?.user.uid else {
                    print("Error retrieving user UID.")
                    return
                }
                
                db.collection("Educators").document(uid).setData(educatorData) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        self.removeEducator(educator: educator)
                    }
                }
            }
        }
    }
}

