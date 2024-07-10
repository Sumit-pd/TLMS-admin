//
//  TargetsCardView.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//

import SwiftUI

struct TargetsCardView: View {
    
    @State var courseService  = CourseServices()
    @State var targetName : String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationLink( destination: CoursesView(targetName: targetName)){
            
            HStack(alignment : .center){
                Image(systemName: "circle.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor( Color(hex: "#D2CDFA")!)
                    .frame(width: 30, height: 30)
                
                Spacer()
                
                Text(targetName)
                    .foregroundColor(.black)
                    .font(.custom("Poppins-Medium", size: 20))
                    .font(.title2)
                    .padding(.trailing,10)
                
                Spacer()
                Button(action: {
//                    viewModel.removeTarget(target: targetName)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.black)
                }
                
            }
            .scenePadding()
            
            .frame(width: 345,height: 86,alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.black, lineWidth: 1))
            .padding()
            
        }
        
    }
    
}

struct TargetCard_Previews: PreviewProvider {
    static var previews: some View {
        TargetsCardView(targetName: "Dummy")
    }
}

