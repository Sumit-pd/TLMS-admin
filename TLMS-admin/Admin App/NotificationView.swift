//
//  NotificationView.swift
//  TLMS-admin
//
//  Created by Abcom on 15/07/24.
//

import SwiftUI

struct NotificationView: View {
    @State private var check = false
    @State private var selectedSegment = 0
    @ObservedObject var firebaseFetch = FirebaseFetch()
    var courses : [Course] = [Course(courseID: UUID(), courseName: "Swift UII", courseDescription: "New Course fatched", assignedEducator: Educator.init(firstName: "Fahar", lastName: "Imran", about: "this is howe we do it there is no other way ", email: "fahar123@gmail.com", password: "Fahar@123", phoneNumber: "9809874564", profileImageURL: ""), target: "new", state: "created")]
    var educator : Educator = Educator(firstName: "Fahar", lastName: "Imran", about: "this is howe we do it there is no other way ", email: "fahar123@gmail.com", password: "Fahar@123", phoneNumber: "9809874564", profileImageURL: "")
    
    private let segments = ["Updates", "Educators"]
    
    var body: some View {
        NavigationView{
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
                            ForEach(courses) { course in
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
                    VStack () {
                        GeometryReader { geometry in
                            ScrollView{
                                VStack(){
                                    if firebaseFetch.pendingEducators.isEmpty {
                                        Text("No Educators")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(.black))
                                            .opacity(0)
                                            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.4)
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(firebaseFetch.pendingEducators) { educator in
                                EducatorperCardView(educator: educator)
                            }
                        }
                        .background(Color("color 3"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                        .padding(10)
                        .onAppear() {
                            firebaseFetch.fetchPendingEducators()
                        }
                    }
                }
                
            }.navigationTitle("Notifications")
                .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
    
}

#Preview {
    NotificationView()
}
    
struct EducatorperCardView: View {
    var educator : Educator
    var body: some View {
        NavigationLink(destination: EducatorAccept(educator: educator)) {
            HStack(spacing: 10){
                ProfileCircleImage(imageURL: educator.profileImageURL, width: 60, height: 60)
                VStack(alignment: .leading, spacing: 5){
                    Text(educator.fullName)
                        .font(.custom("Poppins-Medium", size: 18))
                    Text(educator.about)
                        .font(.custom("Poppins-Regular", size: 16))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }   
            .padding(15)
        }
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
