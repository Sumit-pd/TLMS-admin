//
//  CourseServices.swift
//  TLMS-admin
//
//  Created by Abcom on 05/07/24.
//

//import Foundation
//import SwiftUI
//import FirebaseFirestore
//import FirebaseStorage
//
//class CourseContent {
//    static func uploadCourseTitleImage(image : Image, completion: @escaping (Bool) -> Void) {
//        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
//            completion(false)
//            return
//        }
//        
//        let storageRef = Storage.storage().reference().child("Courses")
//        
//       storageRef.putData(image, metadata: nil) { metadata, error in
//            if let error = error {
//                print("Failed to upload image: \(error.localizedDescription)")
//                completion(false)
//                return
//            }
//            
//            storageRef.downloadURL { url, error in
//                guard let imageURL = url?.absoluteString else {
//                    completion(false)
//                    return
//                }
//                
//                let timeStamp = Date().timeIntervalSince1970
//                let post = Post(postID: postID, userID: userID, caption: caption, imageURL: imageURL, timeStamp: timeStamp, category: category)
//                
//                let postsRef = Database.database().reference().child("posts").child(postID)
//                let userPostsRef = Database.database().reference().child("users").child(userID).child("posts").child(postID)
//                
//                postsRef.setValue(post.toDictionary()) { error, _ in
//                    if let error = error {
//                        print("Failed to upload post data: \(error.localizedDescription)")
//                        completion(false)
//                        return
//                    }
//                }
//            }
//        }
//    }
//    
//}
