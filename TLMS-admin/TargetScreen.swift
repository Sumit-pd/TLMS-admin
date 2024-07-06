//
//  ContentView.swift
//  tlms_target_creation
//
//  Created by Divyansh Kaushik on 04/07/24.
//

import SwiftUI

struct TargetScreen: View {
    
    @State private var isPresentingNewTarget = false
    @StateObject private var viewModel = TargetViewModel()
    var body: some View {
  
            ScrollView {
                VStack{
                    HStack(alignment: .center){
//                        Text("Target")
                        TitleLabel(text:
                        "Target")
                        .font(.largeTitle)
                        .foregroundColor(Color(hex: "#000000")!)
                        .fontWeight(.bold)
                                
                            Spacer()
                                
                            Button(action: {
                                    isPresentingNewTarget = true
                                }) {
                                    
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(Color(hex: "#6C5DD4")!)
                                        
                                        Text("Add Target")
                                        .font(.subheadline)
                                            .foregroundColor(Color(hex: "#6C5DD4")!)
                                            .fontWeight(.bold)
                                    
                                }
                            }
                    .padding()
                        
                    
                    if viewModel.targets.isEmpty {
                        Text("No Target")
                            .opacity(0.5)
                            .foregroundColor(Color(hex: "#6C5DD4")!)
                            .font(.custom("headline", size: 24))
                            .fontWeight(.bold)
                            .padding(.top, 200)
                    } else {
                        
                        ForEach(viewModel.targets) { target in
                            VStack (alignment : .leading){
                                HStack(alignment : .center){  
                                    Image(systemName: "circle.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color(hex: "#D2CDFA")!)
                                        .frame(width: 20, height: 20)
                                    
                                    Spacer()
                                    
                                    Text(target.title)
                                        .foregroundColor(.black)
                                        .font(.custom("Poppins-Medium", size: 20))
                                        .font(.title2)
                                        .padding(.trailing,10)
                                    
                                    Spacer()
                    
                                    //Button
                                    Button(action: {
                                        viewModel.removeTarget(target: target)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                                .scenePadding()
                                
                            }
                            .frame(width: 345,height: 86,alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.black, lineWidth: 1))
                        }.padding(.bottom, 10)
                    }
                }
                .sheet(isPresented: $isPresentingNewTarget) {
                    NewTargetScreen(viewModel: viewModel)
                }
            }
            
                
                   
            
            .sheet(isPresented: $isPresentingNewTarget) {
                NewTargetScreen(viewModel: viewModel)
            }
    }
            
    }

struct NewTargetScreen: View {
    @ObservedObject var viewModel: TargetViewModel
    @State private var newTargetTitle: String = ""
    @State private var textTitle: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Target")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.init(top: 0, leading: 40, bottom: 0, trailing: 0))
                Spacer()
                Button(action: {
                    if !textTitle.isEmpty {
                        viewModel.addTarget(title: textTitle)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Done")
                        .font(.title3)
                }
            }
            .padding()
            
            Divider()
                .padding(.horizontal)
            
            TextField("Add Target Title", text: $textTitle)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}


//func addTargetHit(title : String)-> some View {
//    ForEach(viewModel.targets) { target in
//        VStack (alignment : .leading){
//            HStack(alignment : .center){  Image(systemName: "circle")
//                    .overlay(
//                        Circle()
//                            .stroke(.purple, lineWidth: 4))
//                
//                Spacer()
//                
//                Text(title)
//                    .foregroundColor(.black)
//                    .font(.title2)
//                    .padding(.trailing,10)
//                
//                Spacer()
//                
//                
//                
//                Button(action: {
//                    viewModel.removeTarget(target: target)
//                }) {
//                    Image(systemName: "trash")
//                        .foregroundColor(.black)
//                }
//            }
//            .scenePadding()
//            
//        }
//        .frame(width: 354,height: 86,alignment: .center)
//        .cornerRadius(12)
//        //                                              .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
//        //                                              .padding(.bottom, 5)
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(.black, lineWidth: 1))
//    }
//}
//
//    .sheet(isPresented: $isPresentingNewTarget) {
//        NewTargetScreen(viewModel: viewModel)
//    }

#Preview {
    TargetScreen()
}
