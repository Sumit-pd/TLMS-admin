//
//  TargetsCardView.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//

import SwiftUI

import SwiftUI

struct TargetsCardView: View {
    @State var target : Target
    @StateObject private var viewModel = TargetViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationLink( destination: CoursesView(target: target)){
            
            HStack(alignment : .center){
                Image(systemName: "circle.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor( Color(hex: "#D2CDFA")!)
                    .frame(width: 30, height: 30)
                
                Spacer()
                
                Text(target.targetName)
                    .foregroundColor(.black)
                    .font(.custom("Poppins-Medium", size: 20))
                    .font(.title2)
                    .padding(.trailing,10)
                
                Spacer()
                Button(action: {
                    viewModel.removeTarget(target: target)
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


// Provide a valid preview implementation
struct GoalCard_Previews: PreviewProvider {
    static var previews: some View {
        let target = Target(targetName: "Dummy target")
        TargetsCardView(target: target)
    }
}

