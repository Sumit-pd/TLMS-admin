//
//  StatsView.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 15/07/24.
//

import SwiftUI
import FirebaseAuth
struct StatsView: View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
//    var course: Course
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Statscard()
                }
                .padding(20)
                .frame(width: .infinity)
                
            }
            .navigationTitle("Enrollments")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    StatsView()
}


struct Statscard: View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
//    var course: Course
    @State var isRefreshing = false
    @EnvironmentObject var authViewModel : UserAuthentication
    var body: some View {
       
        VStack(alignment: .leading, spacing: 20) {
            
            TotalEnrollment()
            
            CourseEnrollment()

            HStack {
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        authViewModel.signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                }) {
                    Text("Sign Out")
                        .foregroundColor(.blue)
                }
                .padding()
                Button(action : {
                    isRefreshing.toggle()
                }) {
                    Image(systemName: "arrow.circlepath")
                }
            }

        }
        
    }
}

struct TotalEnrollment: View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Total Enrollments")
                .font(.custom("Poppins-SemiBold", size: 18))
            ZStack(alignment: .bottom){
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("color 2"))
                    .frame(width: .infinity, height: 100)
                PNGImageView(imageName: "wave2", width: .infinity, height: .infinity)
                    
                
                HStack(){
                    VStack {
                        Text("\(firebaseFetch.educators.count)")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                        Text("Educator")
                            .font(.custom("Poppins-Medium", size: 18))
                    }
                    Divider()
                    VStack {
                        Text("\(firebaseFetch.learners.count)")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                        Text("Learners")
                            .font(.custom("Poppins-Medium", size: 18))
                        
                    }
                }
                .onAppear() {
                    firebaseFetch.fetchLearners()
                    firebaseFetch.fetchEducators()
                }
                
            }.frame(height: 100)
        }
            
            
        
    }
}

struct CourseEnrollment : View {
    
    @State var courseService  = CourseServices()
    @ObservedObject var firebaseFetch = FirebaseFetch()
//    var course: Course
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Courses Enrollments")
                .font(.custom("Poppins-SemiBold", size: 18))
           
//                ForEach(course)
            VStack{
                ForEach(firebaseFetch.courses.filter{$0.state == "published"}) {
                    course in
                    CustomCard(course: course)
                }
            }
                .onAppear() {
                    firebaseFetch.fetchCourses()
                }
            }
        
            
    }
}

struct CustomCard : View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    var course : Course
    var body: some View {
        HStack{
            CoursethumbnailImage(imageURL: course.courseImageURL, width: 80, height: 80)
            Text(course.courseName)
                .font(.custom("Poppins-Medium", size: 20))
                .frame(maxWidth: 200, alignment: .leading)
                .lineLimit(1)
            Spacer()
            Text("\(course.numberOfStudentsEnrolled ?? 0)")
                .font(.custom("Poppins-Bold", size: 24))
            
        }
        .padding(10)
        .frame(width: 360, height: 100)
        .background(Color("color 2"))
    .cornerRadius(12)
    }
}
