//
//  HeadlineText.swift
//  TLMS-admin
//
//  Created by Abcom on 07/07/24.
//

import Foundation
import SwiftUI

struct HeadlineText : View{
    var text1 : String
    
    var body: some View {
        
        Text(text1)
            .font(.headline)
            .bold()
            .foregroundColor(.black)
            .lineLimit(1)
    }
}

struct SubHeadlineText : View{
    var text2 : String
    
    var body: some View {
        
        Text(text2)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(1)
    }
}
