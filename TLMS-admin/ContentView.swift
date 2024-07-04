//
//  ContentView.swift
//  TLMS-admin
//
//  Created by Sumit Prasad on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    var body: some View {
        VStack {
            CustomButton(label: "Click Me") {
                print("Button Pressed!")}
            CustomTextField(placeholder: "Enter text here", text: $inputText)
            TitleLabel(text: "Hello, World!")
            PNGImageView(imageName: "MainScreenImage", width: 100, height: 100)
            }
        HeadingLabel(text: "Main")
            
        }
    }


#Preview {
    ContentView()
}
