//
//  NotificationView.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 12/07/24.
//

import SwiftUI

struct NotificationView: View {
    @State private var check = false
    @State private var selectedSegment = 0
    @ObservedObject var firebaseFetch = FirebaseFetch()
    var course : Course = Course(courseID: UUID(), courseName: "Swift UII", courseDescription: "New Course fatched", assignedEducator: Educator.init(firstName: "Fahar", lastName: "Imran", about: "this is howe we do it there is no other way ", email: "fahar123@gmail.com", password: "Fahar@123", phoneNumber: "9809874564", profileImageURL: ""), target: "new")
    var educator : Educator = Educator(firstName: "Fahar", lastName: "Imran", about: "this is howe we do it there is no other way ", email: "fahar123@gmail.com", password: "Fahar@123", phoneNumber: "9809874564", profileImageURL: "")
    
    private let segments = ["Updates", "Educators"]
    
    var body: some View {
        NavigationStack{
                VStack {
                    Picker("Select Segment", selection: $selectedSegment) {
                        ForEach(0..<segments.count) { index in
                            Text(segments[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    
                    if selectedSegment == 0 {
                        ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(firebaseFetch.pendingEducators) { educator in
                                                        UpdateCardView(course: course, educator: educator)
                                                    }
                                                }
                                                .frame(width: 354, height: 100)
                                                .background(Color("color 3"))
                                                .cornerRadius(12)
                                                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                                                .padding(10)
                        }
                      
                    } else if selectedSegment == 1 {
                        
                        ScrollView {
                            NavigationLink(destination: EducatorProfile(action: {}), isActive: $check) {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(firebaseFetch.pendingEducators) { educator in
                                        EducatorperCardView(course: course, educator: educator)
                                    }
                                }
                                .frame(width: 354, height: 100)
                                .background(Color("color 3"))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                                .padding(10)
                            }
                        }
                        
                    }
                }
                
            }
        
    }
}
        #Preview {
            NotificationView()
        }
    
        struct EducatorperCardView: View {
            var course : Course
            var educator : Educator
            var body: some View {
                    HStack(spacing: 10){
                        PNGImageView(imageName: "SwiftLogo", width: 100, height: 100)
                        VStack(alignment: .leading, spacing: 5){
                            Text(course.assignedEducator.firstName + course.assignedEducator.lastName)
                                .font(.custom("Poppins-Medium", size: 18))
                            Text(educator.about)
                                .font(.custom("Poppins-Regular", size: 16))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }   .padding(15)
                
            }
        }

struct UpdateCardView: View {
    var course : Course
    var educator : Educator
    var body: some View {
           
                HStack(spacing: 10){
                    PNGImageView(imageName: "SwiftLogo", width: 100, height: 120)
                    VStack(alignment: .leading, spacing: 5){
                        Text(course.courseName)
                            .font(.custom("Poppins-Medium", size: 18))
                        Text(course.assignedEducator.firstName + course.assignedEducator.lastName)
                            .font(.custom("Poppins-Regular", size: 16))
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
                    .padding(15)
    }
        
}
  
