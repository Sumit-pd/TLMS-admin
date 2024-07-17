//
//  PublishCourse.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 17/07/24.
//

import SwiftUI

struct PublishCourse: View {
    @State var courseService = CourseServices()
    var course : Course
    @State var modules : [String] = []
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                CoursethumbnailImage(imageURL: course.courseImageURL, width: 354, height: 200)
                Text(course.courseName)
                    .font(.custom("Poppins-SemiBold", size: 24))
                Text(course.courseDescription)
                    .font(.custom("Poppins-Regular", size: 18))
                ModuleSection(course: course, modules: modules)
                
                
                
            }.padding(20)
                .navigationTitle("Course Name")
                .navigationBarTitleDisplayMode(.inline)
            VStack {
                CustomButton(label: "Publish", action: {})
            }
        }
        .onAppear() {
            allModules()
        }
    }
    
    
    func allModules() {
        courseService.fetchModules(course: course) { modules in
            self.modules = modules
        }
    }
}




struct ModuleSection: View {
    @State var courseService = CourseServices()
    var course : Course
    var modules : [String]
    
    var body: some View {
        ForEach(modules, id: \.self){ module in
            VStack(alignment: .leading){
                Text(module)
                    .font(.custom("Poppins-SemiBold", size: 18))
                ModuleCard()
            }
        }
    }
}


struct ModuleCard: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 0){
            
            HStack(spacing: 10){
                Image("SwiftLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 50)

                    Text("Video Title")
                        .font(.custom("Poppins-Medium", size: 18))
                        .lineLimit(1)
                Spacer()
                Button(action: {}) {
                                   Text("Review")
                                       .foregroundColor(.white)
                                       .padding()
                                       .frame(width: 100,height: 45)
                                       .background(Color("color 1")
                                       )
                                       .cornerRadius(20)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(Color.white, lineWidth: 0.8)
                                       )
                               }
            }
            .frame(width: 354)
            .padding(10)
            Divider()
            //Video Review Card
            HStack(spacing: 10){
                Image("SwiftLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 50)
              
                Text("Notes Title")
                    .font(.custom("Poppins-Medium", size: 18))
                    .lineLimit(1)
                Spacer()
                Button(action: {}) {
                                   Text("Review")
                                       .foregroundColor(.white)
                                       .padding()
                                       .frame(width: 100,height: 45)
                                       .background(Color("color 1")
                                       )
                                       .cornerRadius(20)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(Color.white, lineWidth: 0.8)
                                       )
                               }
                
            }.padding(10)
            
        }.background(Color("color 3"))
            .cornerRadius(12)
    }
}


//class CoursesListViewModel: ObservableObject {
//    @Published var courses: [Course] = []
//    private let courseService = CourseServices()
//
//    func fetchCourses(targetName: String) {
//        courseService.fetchCoursesByTarget(targetName: targetName) { courses, error in
//            if let error = error {
//                print("Error fetching courses: \(error.localizedDescription)")
//                return
//            }
//            
//            if let courses = courses {
//                DispatchQueue.main.async {
//                    self.courses = courses
//                }
//            }
//        }
//    }
//}


#Preview {
    PublishCourse(course: Course(courseID: UUID(), courseName: "afdsf", courseDescription: "sdfs", assignedEducator: Educator(firstName: "sdfsd", lastName: "sdfsd", about: "sdfsd", email: "fsdf", password: "sdfsdf", phoneNumber: "sdfsd", profileImageURL: "sdfsdf"), target: "fasd", state: "asdfa"))
}
