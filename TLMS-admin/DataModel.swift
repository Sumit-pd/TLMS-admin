//
//  DataModel.swift
//  TLMS-admin
//
//  Created by Abcom on 04/07/24.
//

import Foundation

struct Admin {
    var AdminID : UUID
    var name : String
    var email : String
    var password : String
    var userRole : userRoles
}

struct Target {
    var targetName : String
    var courses : [Course]
}

struct Course {
    var courseName : String
    var courseDescription : String
    var courseImage : String
    var assignedEducator : Educator
    var content : Content?
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

struct Educator {
    var EducatorID : UUID
    var EducatorName : String
    var educatorProfileImage : String
    var email : String
    var password : String
    var userRole : userRoles
}

enum userRoles {
    case learners, educators, pendingEducators, admin
}
