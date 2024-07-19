//
//  EducatorProfile.swift
//  TLMS-admin
//
//  Created by Abcom on 15/07/24.
//

import SwiftUI
import FirebaseAuth


struct EducatorProfile: View {
    @State var educator : Educator
    @ObservedObject var fireBaseFatch = FirebaseFetch()
    @State var userID = Auth.auth().currentUser?.uid
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            PNGImageView(imageName: "Waves", width: .infinity, height: .infinity)
                .padding(.top, 120)
            
            VStack(alignment: .leading, spacing: 10){
                ProfileEducatorImage(imageName: educator.profileImageURL, width: 354, height: 200)
                    .padding(.top ,30)
                    
                Text(educator.firstName + " " + educator.lastName)
                    .font(.custom("Poppins-SemiBold", size: 20))
                Text(educator.about)
                    .font(.custom("Poppins-Medium", size: 16))
                Text(educator.email)
                VStack(alignment: .leading){
                    Text("Assigned Courses")
                                    .font(.headline)
                                    
                    ScrollView(.horizontal){
                        ForEach(fireBaseFatch.assignedCourses) {course in
                            AssignedCourseCardView(course: course)
                        }
                    }
                    
                }
                
                .padding(.top,20)
                Spacer()
            }
            .onAppear(){
                fireBaseFatch.fetchAssignedCourses(educatorID: userID!)
            }
//            .padding(.top, 100)
            .padding(20)
            .navigationTitle("Educator")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea()
    }
}


struct AssignedCourseCardView: View {
    
    var course : Course
    
    var body: some View {
        ZStack(alignment: .bottom){
            CoursethumbnailImage(imageURL: course.courseImageURL, width: 354, height: 200)
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("color 1"), Color("color 3")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                ).frame(width: 354, height: 80)
                .opacity(0.7)
            VStack(alignment: .leading){
                Text(course.courseName)
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .foregroundColor(.black)
                Text(course.courseDescription)
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(.black)
                    .lineLimit(1)
            }.padding(10)
            
        }
        
        .frame(width: 354, height: 200)
        
    }
    
}

