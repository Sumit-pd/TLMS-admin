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
    var id: String {courseID.uuidString}
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
    var state : String     //Created, Empty, Filled, Published
}

struct Content {
    var quiz : Quiz
    var modules : [Module]
    var certificateURL : String?
}

struct Quiz {
    var questions : [Question]
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
    var fullName : String {firstName+" "+lastName}
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

struct Learner  : Identifiable{
    var id: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var completedCourses: [String]?
    var enrolledCourses: [String]?
    var goal: String?
    var joinedDate: String?
    var likedCourses: [String]?
}

enum userRoles {
    case learners, educators, pendingEducators, admin
}
