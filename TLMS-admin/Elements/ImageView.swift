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
                    .frame(width: width, height: height)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(12)
            }
                    placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 60)
                    }
                    
            
                    
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



extension Color {
    init(hexc: String) {
        let scanner = Scanner(string: hexc)
        scanner.scanLocation = hexc.hasPrefix("#") ? 1 : 0

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0x00ff00) >> 8
        let b = rgbValue & 0x0000ff

        self.init(
            .sRGB,
            red: Double(r) / 0xff,
            green: Double(g) / 0xff,
            blue: Double(b) / 0xff,
            opacity: 1
        )
    }
}
