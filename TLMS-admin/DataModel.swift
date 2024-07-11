//
//  DataModel.swift
//  TLMS-admin
//
//  Created by Abcom on 04/07/24.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct Admin {
    var AdminID : UUID
    var name : String
    var email : String
    var password : String
    var userRole : userRoles
}

struct Target : Identifiable{
//    var documentID : String
    var id : UUID = UUID()
   
    var targetName : String
    var courses : [Course]?
}

struct Course : Identifiable{
    var id: String?
    var courseID : UUID
    var courseName : String
    var courseDescription : String
    var courseImageURL : String?
    var courseImage : UIImage?
    var releaseDate : Date?
    var assignedEducator : Educator
    var content : Content?
    var numberOfStudentsEnrolled : Int?
    var likeCount : Int?
    var target : String
    
    func toDictionary() -> [String:Any]{
        return [
            "courseID" : courseID,
            "courseName" : courseName,
            "courseDescription" : courseDescription,
            "courseThumbnailURL" : courseImage,
            "releaseDate" : releaseDate,
            "assignedEducator" : assignedEducator.id,
            "target" : target,
            "content" : content,
            "likeCount" : likeCount,
            "numberOfEnrollments" : numberOfStudentsEnrolled
        ]
    }
}

struct Content {
    var quiz : Quiz
    var notes : [String]
    var videos : [String]
}

struct Quiz {
    var questions : [Question]
    var maxScore : Int {
        questions.count * 5
    }
    var score : Int
}

struct Question {
    var questionText : String
    var options : [String]
    var correctOptionNumber : Int
}

// ************************************ //
// ************************************ //
// ************************************ //

struct Educator : Identifiable{
    var id: String?
    
    var firstName: String
    var lastName : String
    var about: String
    var email: String
    var password: String
    var phoneNumber: String
    var profileImageURL: String
    var profileImage: UIImage?

    func toDictionary() -> [String: Any] {
        return [
            "FirstName": firstName,
            "LastName": lastName,
            "email": email,
            "password": password,
            "phoneNumber": phoneNumber,
            "about": about,
            "profileImageURL": profileImageURL
        ]
    }
}

enum userRoles {
    case learners, educators, pendingEducators, admin
}
