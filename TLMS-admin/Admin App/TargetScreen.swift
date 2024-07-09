//
//  ContentView.swift
//  tlms_target_creation
//
//  Created by Divyansh Kaushik on 04/07/24.
//

import SwiftUI
import FirebaseAuth

struct TargetScreen: View {
    
    @EnvironmentObject var authViewModel : UserAuthentication
    @State private var isPresentingNewTarget = false
    @State private var isSelected = false
    @StateObject private var viewModel = TargetViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack{
                    HStack(alignment: .center){
                        TitleLabel(text: "Target")
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
//                    .padding()
                    
                    
//                    Button(action: {
//                        do {
//                            try Auth.auth().signOut()
//                            authViewModel.signOut()
//                        } catch let signOutError as NSError {
//                            print("Error signing out: %@", signOutError)
//                        }
//                    }) {
//                        Text("Sign Out")
//                            .foregroundColor(.blue)
//                    }
                    .padding()
                    
                    if viewModel.targets.isEmpty {
                        Text("No Target")
                            .opacity(0.5)
                            .foregroundColor(Color(hex: "#6C5DD4")!)
                            .font(.custom("headline", size: 24))
                            .fontWeight(.bold)
                            .padding(.top, 200)
                    } else {
                        ForEach(viewModel.targets) {
                            target in TargetsCardView(target: target)
                        }
                        
//                        .navigationTitle("Our Target")
//                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
            .sheet(isPresented: $isPresentingNewTarget, content: {
                NewTargetScreen(viewModel: viewModel)
            })
                }
            }
    
            
    

struct NewTargetScreen: View {
    @ObservedObject var viewModel: TargetViewModel
    @State private var TargetTitle: String = ""
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
                    if !TargetTitle.isEmpty {
                        viewModel.addTarget(title: TargetTitle)
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
            
            TextField("Add Target Title", text: $TargetTitle)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TargetScreen()
}


//Button(action : {
//    print("Course Creation")
//    navigateToCourseCreation.toggle()
//    
//}) {
//    Text("Create a Course")
//}
//NavigationLink(destination: CourseCreationView(), isActive: $navigateToCourseCreation) {
//    EmptyView()
//}
