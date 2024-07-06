//
//  MainScrene.swift
//  TLMS-admin
//
//  Created by Priyanshu Gupta on 03/07/24.
//

import Foundation
import SwiftUI

struct MainView:View{
    var body: some View{
        NavigationView{
            VStack{
                MainScreenView()
            }
            
        }
    }
    
}
struct Main_Preview:
    PreviewProvider{
    static var previews: some View{
        MainView()
    }
}

struct AdminButton:View {
    var title:String
    var body: some View {
        
        NavigationLink(destination: AdminScreen()){
            CustomButton(label: "Login as Admin"){
                print("Button Pressed!")
            }
            
        }
        
    }
}
struct EducatorButton:View {
    var title:String
    var body: some View {
        NavigationLink(destination: EducatorScreen()){
            CustomButton(label: "Login as Educator"){
                print("Button Pressed!")
            }
            
        }
    }
}
struct MainScreenView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                TitleLabel(text: "Welcome To Svadhyay")
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                Text("Countinuous Learnzing " + "Made Easy")
                    .font(.custom("Poppins-Light", size: 25))
                    .foregroundColor(Color(UIColor(named: "PrimaryColour")!))
                    .frame(maxWidth: 400 ,maxHeight: .infinity, alignment: .leading)
                    
                
                
                Spacer()
                PNGImageView(imageName: "MainScreenImage", width: 436, height: 325)
                Spacer()
                    AdminButton(title: "Login as Admin")
                    EducatorButton(title: "Login as Educator")
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 80)
            .ignoresSafeArea()
            .background(Color(UIColor(named: "BackgroundColour")!))
        }
    }
}
