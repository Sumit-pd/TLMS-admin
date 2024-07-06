//
//  TargetPage.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 05/07/24.
//

import SwiftUI

struct TargetPage: View {
    let target : Targets
    var body: some View {
        VStack{
            HStack{
                PNGImageView(imageName: "MainScreenImage", width: 20, height: 20)
                Spacer()
                Text(target.title)
                    
               
            }.padding(.horizontal)
        }
        .frame(maxWidth : .infinity, minHeight: 86)
//        .background(RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#FFFFFF")!).shadow(radius: 2))
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1).cornerRadius(12)
        .padding(.horizontal)
            
            
    }
}

#Preview {
    TargetPage(target: Targets(title: "UPSE"))
}
