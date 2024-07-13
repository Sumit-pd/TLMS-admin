//
//  EducatorProfile.swift
//  TLMS-admin
//
//  Created by Fahar Imran on 13/07/24.
//

import SwiftUI

struct EducatorProfile: View {
    var action: () -> Void
    var body: some View {
    
        ZStack{
            PNGImageView(imageName: "uprectange", width: .infinity, height: .infinity)
            
            VStack(alignment: .leading, spacing: 10){
                EducatorImage(imageName: "educator", width: 354, height: 200)
                Text("Babu Bhaiya")
                    .font(.custom("Poppins-SemiBold", size: 28))
                    .fontWeight(.bold)
                
                Text("This is how do it there is no other way you se how do it This is how do it there is no other way you se how do it  ")
                    .font(.custom("Poppins-SemiBold", size: 16))
                
                Text("faharimran123@gmail.com")
                    .font(.custom("Poppins-Medium", size: 16))
                Text("9876234198")
                    .font(.custom("Poppins-Medium", size: 16))
                Spacer()
                HStack(alignment: .center){
                    Button(action: action) {
                        Text("Deny")
                            .frame(width: 168, height: 51)
                            .background(Color(hex : "#6C5DD4")) // You can change the color as needed
                            .foregroundColor(.white) // Text color
                            .cornerRadius(10) // Optional: to make corners rounded
                            .font(.custom("Poppins-Medium", size: 17.0))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    Button(action: action) {
                        Text("Accept")
                            .frame(width: 168, height: 51)
                            .background(Color(hex : "#6C5DD4")) // You can change the color as needed
                            .foregroundColor(.white) // Text color
                            .cornerRadius(10) // Optional: to make corners rounded
                            .font(.custom("Poppins-Medium", size: 17.0))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            .navigationTitle("Educator")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 100)
            .padding(.bottom,30)
            .padding(20)
        }
        .frame(width: .infinity, height: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    EducatorProfile(action: {})
}
