//
//  CoursesView.swift
//  TLMS-admin
//
//  Created by Abcom on 08/07/24.
//


import SwiftUI

struct CoursesView: View {
//    @State private var selectedDomain = "GD, PI & WAT for CAT & OMTs"
    @State private var showModal = false
    @State private var navigateToCoursesCreation = false

    var target : Target

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    GeometryReader { geometry in
                        VStack {
                            Text("No Courses")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("#6C5DD4")) .opacity(0.5)// Custom color with opacity
                                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.4) // Centered text
                        }
                    }
                }
                .padding(.horizontal)

                // Background Image
                Image("homescreenWave")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.bottom) // Extend to the bottom edge
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showModal.toggle() // Toggle modal visibility
                    }) {
                        HStack {
                            Text(target.targetName)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination : CourseCreationView(), isActive: $navigateToCoursesCreation) {
                        
                        
                        Button(action: {
                            navigateToCoursesCreation = true
                            print("Plus button tapped") // Plus button action
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 15)) // Set the button font size to 15
                                .fontWeight(.bold)
                        }
                    }
                }

            }
            .navigationBarHidden(false)
            .edgesIgnoringSafeArea(.bottom) // Ensure content extends behind the tab bar
            .sheet(isPresented: $showModal) {
                DomainSelectionView(target : target, showModal: $showModal)
                    .presentationDetents([.height(200)]) // Adjust the height based on the content
            }
        }
        .navigationBarBackButtonHidden()
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DomainSelectionView: View {
    @State var target : Target
    @Binding var showModal: Bool

    var body: some View {
        VStack {
            Button(action: {
                showModal.toggle()
            }) {
                Text(target.targetName)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
            Button(action: {
                showModal.toggle()
            }) {
                Text("Another Domain")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
            Button(action: {
                showModal.toggle()
            }) {
                Text("Yet Another Domain")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}


#Preview {
//    let target = Target()
    CoursesView(target: Target.init(targetName: "new"))
}
