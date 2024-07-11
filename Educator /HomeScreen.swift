//
//  HomeScreen.swift
//  TLMS-admin
//
//  Created by Vidhi Iyer  on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hi, Educator 👋")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Start teaching!")
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
                        EnrollmentCard(title: "Ongoing Courses", count: 7, color: Color(hexc: "98CCF2"), icon: "play.rectangle.fill")
                    }
                    .padding(.horizontal)
                   
                    
                    // Ongoing Courses
                    SectionHeader(title: "Ongoing Courses")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            CourseCard(title: "Git started", author: "Batman", imageName: "git_logo")
                            CourseCard(title: "Git started", author: "Batman", imageName: "git_logo")
                            CourseCard(title: "Git started", author: "Batman", imageName: "git_logo")
                        }
                        .padding(.horizontal)
                    }
                    
                    // My Courses
                    SectionHeader(title: "My Courses")
                    
                    VStack(spacing: 10) {
                        MyCourseCard(title: "Swift Fundamentals", enrollments: 1898, imageName: "swift")
                        MyCourseCard(title: "Swift Fundamentals", enrollments: 1898, imageName: "python")
                        MyCourseCard(title: "Swift Fundamentals", enrollments: 1898, imageName: "django")
                    }
                    .padding(.horizontal)
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

struct CourseCard: View {
    var title: String
    var author: String
    var imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            Text(title)
                .font(.headline)
            Text("by \(author)")
                .font(.subheadline)
                .foregroundColor(.secondary)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hexc: String) {
        let scanner = Scanner(string: hexc)
        scanner.scanLocation = hexc.hasPrefix("#") ? 1 : 0

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0x00ff00) >> 8
        let b = rgbValue & 0x0000ff

        self.init(
            .sRGB,
            red: Double(r) / 0xff,
            green: Double(g) / 0xff,
            blue: Double(b) / 0xff,
            opacity: 1
        )
    }
}

