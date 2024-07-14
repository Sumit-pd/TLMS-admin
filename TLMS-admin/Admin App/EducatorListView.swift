//
//  EducatorListView.swift
//  TLMS-admin
//
//  Created by Abcom on 15/07/24.
//

import SwiftUI


struct EducatorListView : View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var body: some View {
        VStack (){
            GeometryReader { geometry in
                ScrollView{
                    VStack(){
                        if firebaseFetch.educators.isEmpty {
                            Text("No Educators")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.black))
                                .opacity(0)
                                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.4)
                        } else {
                            ForEach(firebaseFetch.educators){ educator in
                                EducatorsListCard(educator: educator)
                            }
                            .onAppear(){
                                print(firebaseFetch.educators)
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            firebaseFetch.fetchEducators()
        }
    }
}

#Preview {
    EducatorListView()
}



struct EducatorsListCard: View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var educator : Educator
    
    var body: some View {
        NavigationLink(destination: EducatorProfile()){
            HStack(spacing: 10){
                ZStack{
                    ProfileCircleImage(imageURL: educator.profileImageURL, width: 60, height: 60)
                        .scaledToFit()
                        .frame(width: 100, height: 90)
                    
                    Image("blank")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                VStack(alignment: .leading){
                    Text(educator.firstName + " " + educator.lastName)
                        .font(.custom("Poppins-Medium", size: 18))
                    Text(educator.about)
                        .lineLimit(2)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.secondary)
                    
                }
                Spacer()
                //                        Image(systemName: "chevron.right")
            }
        }
        .navigationTitle("Educators")
        //            .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    EducatorsListCard(educator: Educator(id: "Dummyq", firstName: "rhdgsvdgr", lastName: "hdvsx", about: "hregsdvz", email: "htdfbvsc", password: "grdsc", phoneNumber: "bfdvcsxa", profileImageURL: "ngbdvs"))
}
