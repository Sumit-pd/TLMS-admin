//
//  EducatorProfile.swift
//  TLMS-admin
//
//  Created by Abcom on 15/07/24.
//

import SwiftUI

struct EducatorProfile: View {
    var body: some View {
        
        ZStack(alignment: .bottom){
            PNGImageView(imageName: "Waves", width: .infinity, height: .infinity)
            
            VStack(alignment: .leading, spacing: 10){
                Image("educator4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 354, height: 200)
                    .cornerRadius(12)
                    
                Text("Fahar Imran")
                    .font(.custom("Poppins-SemiBold", size: 20))
                Text("About me, this is how we do it there is no other way you see how we move it and i would love to know abote my self more")
                    .font(.custom("Poppins-Medium", size: 16))
                Text("fahar123@gmail.com")
                VStack(alignment: .leading){
                    Text("Assigned Courses")
                                    .font(.headline)
                                    
                    ScrollView(.horizontal){
                        
                        AssignedCourseCardView()
                    }
                }
                .padding(.top,20)
                Spacer()
            }
            .padding(.top, 100)
            .padding(20)
            .navigationTitle("Educator")
            .navigationBarTitleDisplayMode(.inline)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EducatorProfile()
}


struct AssignedCourseCardView: View {
    
    var body: some View {
        ZStack(alignment: .bottom){
            Image("css")
                .resizable()
            //                .scaledToFit()
                .frame(width: 354,height: 200)
                .cornerRadius(12)
            
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
                Text("Course Name")
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .foregroundColor(.black)
                Text("this course is made consist of 12 module  and several quizes and what not")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(.black)
                    .lineLimit(1)
            }.padding(10)
            
        }
        
        .frame(width: 354, height: 200)
        
    }
    
}
