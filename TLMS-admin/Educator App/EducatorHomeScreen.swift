//
//  HomeScreen.swift
//  TLMS-admin
//
//  Created by Vidhi Iyer  on 11/07/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct EducatorHomeScreen: View {
    @EnvironmentObject var authViewModel: UserAuthentication
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack {
                                    Text("Hi, Educator 👋")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text("Start teaching!")
                                }
                                Spacer()
                                Button(action: {
                                    do {
                                        try Auth.auth().signOut()
                                        authViewModel.signOut()
                                    } catch let signOutError as NSError {
                                        print("Error signing out: %@", signOutError)
                                    }
                                }) {
                                    Image(systemName: "gearshape")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                }
                            }
                                .font(.subheadline)
                            Text("Enrollments")
                                .font(.subheadline).padding(.top)
                            
                            
                        }
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Enrollments
                    HStack {
                        EnrollmentCard(title: "Total Courses", count: 15, color: Color(hexc: "A69EE5"), icon: "book.fill")
                        EnrollmentCard(title: "Ongoing Courses", count: firebaseFetch.assignedCourses.filter({$0.state == "processing"}).count, color: Color(hexc: "98CCF2"), icon: "play.rectangle.fill")
                    }
                    .padding(.horizontal)
                    
                    
                    // Ongoing Courses
                    SectionHeader(title: "Ongoing Courses")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(firebaseFetch.assignedCourses.filter{$0.state == "processing"}){ course in
                                CourseCard(title: course.courseName, author: course.assignedEducator.firstName, imageName: course.courseImageURL!)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // My Courses
                    SectionHeader2(title: "My Courses")
                    
                    VStack(spacing: 10) {
                        MyCourseCard(title: "Swift Fundamentals", enrollments: 1898, imageName: "swift")
                        MyCourseCard(title: "Swift Fundamentals", enrollments: 1898, imageName: "python")
                        MyCourseCard(title: "Swift Fundamentals", enrollments: 1898, imageName: "django")
                    }
                    .padding(.horizontal)
                }
                .onAppear() {
                    firebaseFetch.fetchAssignedCourses(educatorID: Auth.auth().currentUser!.uid)
                }
            }
            .navigationBarHidden(true)
        }

    }
}

struct EnrollmentCard: View {
    var title: String
    var count: Int
    var color: Color
    var icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .font(.title)
                Spacer()
                Text("\(count)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Text(title)
                .font(.subheadline)
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}



struct CourseCard: View {
    var title: String
    var author: String
    var imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            CoursethumbnailImage(imageURL: imageName, width: 150, height: 130)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
            Text(title)
                .font(.body)
            Spacer()
        }
        .frame(width: 150)
    }
}

struct MyCourseCard: View {
    var title: String
    var enrollments: Int
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.largeTitle)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text("\(enrollments) Enrollments")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            Text("See All")
                .foregroundColor(.blue)
        }
        .padding(.horizontal)
    }
}

struct SectionHeader2: View {
    var title: String
    @State var navAhead : Bool = false
    
    var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button(action : {
                    navAhead = true
                }) {
                    Text("See All")
                }
            }
            .padding(.horizontal)
        NavigationLink(destination : NotificationPage(educatorID: Auth.auth().currentUser!.uid), isActive: $navAhead) {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EducatorHomeScreen()
    }
}


