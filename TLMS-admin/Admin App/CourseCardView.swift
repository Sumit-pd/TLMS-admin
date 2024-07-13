//
//  CourseCardView.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 11/07/24.
//

import SwiftUI

struct CourseCardView: View {
    
    var body: some View {
        ZStack(alignment : .bottom){

            Image("SwiftLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 354, height: 195)
                   
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
                    Text("Swift UI")
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: 180)
                        .truncationMode(.tail)
                    
                    Text("By vasoli Bhai")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: 100)
                        .truncationMode(.tail)
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
            .frame(width: 354, height: 80)
            
            
        }.frame(width: 354, height: 195)
        
    }
}

#Preview {
    CourseCardView()
}
