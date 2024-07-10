//
//  CourseServices.swift
//  TLMS-admin
//
//  Created by Abcom on 05/07/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class CourseServices : ObservableObject {
    
    func uploadTarget(targetName : String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Targets").document(targetName)
        
        ref.setData([:]) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Document added with ID: \(targetName)")
                completion(true)
            }
        }
    }
    
    func fetchTargets(completion: @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Targets")
        
        ref.getDocuments { (querySnapshot, error) in
            if let _ = error {
                print("Error fetching the target names.")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Documents couldn't be fetched.")
                completion([])
                return
            }
            
            let targetNames = documents.map {$0.documentID}
            print(targetNames)
            completion(targetNames)
            
        }
    }
    
    func uploadCourseToTarget(targetName: String, courseName: String, courseDetails: [String: Any], completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let courseDocument = db.collection("Target").document(targetName).collection("Courses").document(courseName)
        
        courseDocument.setData(courseDetails) { error in
            if let error = error {
                print("Error adding course: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Course added with ID: \(courseName)")
                completion(true)
            }
        }
    }
}

