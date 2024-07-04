//
//  ContentView.swift
//  tlms_target_creation
//
//  Created by Divyansh Kaushik on 04/07/24.
//

import SwiftUI

struct TargetScreen: View {
    @State private var isPresentingNewTarget = false

    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Text("Target")
                        .position(CGPoint(x: 50.0, y: -25.0))
                        .font(.title)
                        .font(.custom("Poppins", size: 34.0))
                        .fontWeight(.bold)

                    Text("No Target")
                        .position(x: 175, y: 275)
                        .opacity(0.5)
                        .foregroundColor(Color(UIColor(hex: "#6C5DD4") ?? .black))
                        .font(.custom("headline", size: 24))
                        .fontWeight(.bold)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingNewTarget = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(UIColor(hex: "#6C5DD4") ?? .black))
                                .frame(width: 20, height: 20)
                                .position(CGPoint(x: 5, y: 20))
                            Text("+")
                                .foregroundColor(.white)
                                .font(.custom("Poppins", size: 20))
                                .frame(width: 20, height: 20)
                                .position(CGPoint(x: 5, y: 18))
                            Text("Add Target")
                                .foregroundColor(Color(UIColor(hex: "#6C5DD4") ?? .black))
                                .fontWeight(.bold)
                                .frame(width: 100, height: 40)
                                .position(CGPoint(x: 65.0, y: 20))
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewTarget) {
                NewTargetScreen()
            }
        }.navigationBarBackButtonHidden()
        .padding()
    }
}

#Preview {
    TargetScreen()
}
