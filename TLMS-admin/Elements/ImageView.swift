//
//  ImageView.swift
//  TLMS-admin
//
//  Created by Abcom on 06/07/24.
//

import Foundation
import SwiftUI

// Custom Image struct
struct PNGImageView: View {
    var imageName: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        // Load the image and apply constraints
        if let uiImage = UIImage(named: imageName),
           uiImage.isPNG() {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
        } else {
            // Placeholder or error handling for non-PNG images or image not found
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .foregroundColor(.red)
        }
    }
}

// UIImage extension to check for PNG format
extension UIImage {
    func isPNG() -> Bool {
        guard let data = self.pngData() else { return false }
        return UIImage(data: data) != nil
    }
}

struct ProfileCircleImage: View {
    var imageURL: String?
    var width : CGFloat?
    var height : CGFloat?

    var body: some View {
        if let urlString = imageURL, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipShape(Circle())
                        }
                    placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 60)
                    }
                    .padding(.vertical, 8)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
                .clipShape(Circle())
                .padding(.vertical, 8)
        }
    }
}


struct CoursethumbnailImage: View {
    var imageURL: String?
    var width : CGFloat?
    var height : CGFloat?

    var body: some View {
        if let urlString = imageURL, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .cornerRadius(12)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                 
            }
                    placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 60)
                    }
                    
            
                    
      }

    }
}


struct EducatorImage: View {
    var imageName: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        // Load the image and apply constraints
        if let uiImage = UIImage(named: imageName),
           uiImage.isPNG() {
            ZStack(alignment: .bottom){
                Image("greenboard")
                    .resizable()
                    .scaledToFit()
                    
                HStack{
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
            }.frame(width: width, height: height)
        } else {
            
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .foregroundColor(.red)
        }
    }
}
