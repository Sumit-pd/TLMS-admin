//
//  StatsView.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 15/07/24.
//

import SwiftUI
import FirebaseAuth
struct StatsView: View {
//    var course: Course
    var body: some View {
        
            ScrollView{
                VStack{
                    Statscard()
                }
                .padding(20)
               
                
            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.automatic)
        
    }
}

#Preview {
    StatsView()
}


struct Statscard: View {
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
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Total Enrollments")
                .font(.custom("Poppins-SemiBold", size: 18))
            ZStack(alignment: .bottom){
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("color 2"))
                    .frame(height: 100)
                PNGImageView(imageName: "wave2", width: .infinity, height: .infinity)
                    
                
                HStack(){
                    VStack {
                        Text("Data1")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                        Text("Educator")
                            .font(.custom("Poppins-Medium", size: 18))
                    }
                    Divider()
                    VStack {
                        Text("Data2")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                        Text("Learners")
                            .font(.custom("Poppins-Medium", size: 18))
                        
                    }
                }
                
            }.frame(height: 100)
        }
            
            
        
    }
}

struct CourseEnrollment : View {
//    var course: Course
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Courses Enrollments")
                .font(.custom("Poppins-SemiBold", size: 18))
           
//                ForEach(course)
                HStack{
                    CoursethumbnailImage(imageURL: "", width: 80, height: 80)
                    Text("Swift Fundamentals")
                        .font(.custom("Poppins-Medium", size: 20))
                        .frame(maxWidth: 200, alignment: .leading)
                        .lineLimit(1)
                    Spacer()
                    Text("234")
                        .font(.custom("Poppins-Bold", size: 24))
                }
                    .padding(10)
                    .frame(width: 360, height: 100)
                    .background(Color("color 2"))
                .cornerRadius(12)
            }
        
            
    }
}
