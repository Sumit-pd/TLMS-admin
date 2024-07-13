//
//  CourseCardView.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 11/07/24.
//

import SwiftUI

struct CourseCardView: View {
    var course : Course
    var body: some View {
        ZStack(alignment: .bottom){
            CoursethumbnailImage(imageURL: course.courseImageURL, width: 354, height: 195)
            RoundedRectangle(cornerRadius: 12)
                .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("color 1"), Color("color 3")]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                ).frame(width: 354, height: 195)
                .opacity(0.3)
            RoundedRectangle(cornerRadius: 12)
                .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("color 1"), Color("color 3")]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                ).opacity(0.9)
                .frame(height: 80)
            HStack(){
                VStack(alignment: .leading){
                    Text(course.courseName)
                        .font(.custom("Poppins-SemiBold", size: 24))
                        .foregroundColor(.white)
                       
                    
                    Text(course.assignedEducator.firstName)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: 100)
                }
                
                Spacer()
                Button(action: {}) {
                                   Text("Edit")
                                       .foregroundColor(.white)
                                       .padding()
                                       .frame(width: 80,height: 45)
                                       .background(Color("color 1")
                                       )
                                       .cornerRadius(20)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(Color.white, lineWidth: 0.8)
                                       )
                               }
            }.padding(15)
            
        }.frame(width: 354)
        
    }
}

#Preview {
    CourseCardView(course: Course(courseID: UUID(), courseName: "fjsdkf", courseDescription: "thie si ", assignedEducator: Educator(firstName: "vasoli", lastName: "Bhai", about: "theihr", email: "vasoli@gmail.com", password: "Faharimran@12", phoneNumber: "1234567890", profileImageURL: "sfasd"), target: "sdfds", state: "dummy"))
}
