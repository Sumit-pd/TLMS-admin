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

    func fetchModules(course: Course, completion: @escaping ([Module]) -> Void) {
            let db = Firestore.firestore()
            let ref = db.collection("Courses").document(course.courseName).collection("Modules")
            
            ref.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching the modules: \(error)")
                    completion([])
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("Documents couldn't be fetched.")
                    completion([])
                    return
                }
                
                let modules: [Module] = documents.map { doc in
                    let data = doc.data()
                    let title = data["title"] as? String ?? "Untitled"
                    let notesFileName = data["notesFileName"] as? String
                    let notesUploadProgress = data["notesUploadProgress"] as? Double ?? 0.0
                    let videoFileName = data["videoFileName"] as? String
                    let videoUploadProgress = data["videoUploadProgress"] as? Double ?? 0.0
                    
                    return Module(
                        title: title,
                        notesFileName: notesFileName,
                        notesUploadProgress: notesUploadProgress,
                        videoFileName: videoFileName,
                        videoUploadProgress: videoUploadProgress
                    )
                }
                
                print("Fetched Modules: ", modules)
                completion(modules)
            }
        }
    
//    func uploadCourseToTarget(targetName: String, courseName: String, courseDetails: [String: Any], completion: @escaping (Bool) -> Void) {
//        let db = Firestore.firestore()
//        let courseDocument = db.collection("Courses").document(courseName)
//        
//        courseDocument.setData(courseDetails) { error in
//            if let error = error {
//                print("Error adding course: \(error.localizedDescription)")
//                completion(false)
//            } else {
//                print("Course added with ID: \(courseName)")
//                completion(true)
//            }
//        }
//    }
    
    func createCourse(course: Course, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let courseID = course.courseID.uuidString
        let courseRef = db.collection("Courses").document(course.courseName)
        
        let courseData = [
            "courseID": courseID,
            "courseName": course.courseName,
            "courseDescription": course.courseDescription,
            "courseImageURL": course.courseImageURL!,
            "assignedEducator": course.assignedEducator.id!, // Assuming Educator has an id property
            "releaseDate": Timestamp(date: course.releaseDate!),
            "target": course.target,
            "state" : course.state
        ] as [String : Any]
        
        courseRef.setData(courseData) { error in
            if let error = error {
                completion(error)
                return
            }
            
            let educatorRef = db.collection("Educators").document(course.assignedEducator.id!)
            educatorRef.updateData([
                "assignedCourses": FieldValue.arrayUnion([courseID])
            ]) { error in
                completion(error)
            }
        }
    }
    
    func fetchCoursesByTarget(targetName: String, completion: @escaping ([Course]?, Error?) -> Void) {
        let db = Firestore.firestore()
        let coursesRef = db.collection("Courses")
        
        coursesRef.whereField("target", isEqualTo: targetName).getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(nil, nil)
                return
            }
            
            var courses: [Course] = []
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                dispatchGroup.enter()
                let data = document.data()
                guard let courseIDString = data["courseID"] as? String,
                      let courseID = UUID(uuidString: courseIDString),
                      let courseName = data["courseName"] as? String,
                      let courseDescription = data["courseDescription"] as? String,
                      let courseImageURL = data["courseImageURL"] as? String,
                      let assignedEducatorID = data["assignedEducator"] as? String,
                      let releaseDate = (data["releaseDate"] as? Timestamp)?.dateValue(),
                      let target = data["target"] as? String,
                      let state = data["state"] as? String else {
                    dispatchGroup.leave()
                    continue
                }
                
                self.fetchEducatorByID(assignedEducatorID) { educator in
                    if let educator = educator {
                        let course = Course(courseID: courseID, courseName: courseName, courseDescription: courseDescription, courseImageURL: courseImageURL, releaseDate: releaseDate, assignedEducator: educator, target: target, state: state)
                        courses.append(course)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(courses, nil)
            }
        }
    }


    func fetchEducatorByID(_ id: String, completion: @escaping (Educator?) -> Void) {
        let db = Firestore.firestore()
        let educatorRef = db.collection("Educators").document(id)
        
        educatorRef.getDocument { document, error in
            if let error = error {
                print("Error fetching educator: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists,
                  let data = document.data(),
                  let firstName = data["FirstName"] as? String,
                  let lastName = data["LastName"] as? String,
                  let about = data["about"] as? String,
                  let email = data["email"] as? String,
                  let id = data["id"] as? String,
                  let password = data["password"] as? String,
                  let phoneNumber = data["phoneNumber"] as? String,
                  let profileImageURL = data["profileImageURL"] as? String else {
                completion(nil)
                return
            }
            
            let educator = Educator(id: id, firstName: firstName, lastName: lastName, about: about, email: email, password: password, phoneNumber: phoneNumber, profileImageURL: profileImageURL)
            completion(educator)
        }
    }
    
    func updateCourseState(course: Course, newState: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("Courses").document(course.courseName).updateData(["state": newState]) { error in
            completion(error)
        }
    }
}
