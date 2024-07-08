//
//  TitleLabel.swift
//  TLMS-admin
//
//  Created by Abcom on 06/07/24.
//

import Foundation

import SwiftUI

// Custom TitleLabel struct
struct TitleLabel: View {
    var text: String
    var fontSize: CGFloat = 34 // Default font size

    var body: some View {
        
        Text(text)
            
            .font(.custom("Poppins-Bold", size: 34))
            .foregroundColor(.black)
            .frame(maxWidth: 350, alignment: .leading) // Optional: Full width alignment
            .background(Color.clear) // Optional: Background color
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}
