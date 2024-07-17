import SwiftUI

struct EducatorListView : View {
    @State private var check = false
    @State private var selectedSegment = 0
    private let segments = ["Educators", "Learners"]
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var body: some View {
        NavigationView{
            VStack () {
                Picker("Select Segment", selection: $selectedSegment) {
                    ForEach(0..<segments.count) { index in
                        Text(segments[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedSegment == 0 {
                    GeometryReader { geometry in
                        ScrollView{
                            VStack(spacing: 5){
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
                                    }   .frame(width: 354, height: 100)
                                        .background(Color("color 3"))
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                                        .padding(10)
                                        .onAppear(){
                                            print(firebaseFetch.educators)
                                        }
                                }
                            }
                            
                        }.padding(10)
                        
                    }
                } else if  selectedSegment == 1 {
                    GeometryReader { geometry in
                        ScrollView{
                            VStack(spacing: 5){
                                if firebaseFetch.learners.isEmpty {
                                    Text("No Learners")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.black))
                                        .opacity(0)
                                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.4)
                                } else {
                                    ForEach(firebaseFetch.learners){ learner in
                                        LearnerListCard(learner: learner)
                                    }   .frame(width: 354, height: 100)
                                        .background(Color("color 3"))
                                        .cornerRadius(12)
                                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                                        .padding(10)
                                        .onAppear(){
                                            print(firebaseFetch.learners)
                                        }
                                }
                            }
                            
                        }.padding(10)
                        
                    }
                }
            }
            .onAppear() {
                firebaseFetch.fetchEducators()
                firebaseFetch.fetchLearners()
            }
//            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct EducatorsListCard: View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var educator : Educator
    
    var body: some View {
        NavigationLink(destination: EducatorProfile()){
            HStack(spacing: 10){
                ProfileCircleImage(imageURL: educator.profileImageURL, width: 60, height: 60)

                VStack(alignment: .leading){
                    Text(educator.firstName + " " + educator.lastName)
                        .font(.custom("Poppins-Medium", size: 18))
                    Text(educator.about)
                        .lineLimit(2)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.secondary)
                    
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(10)
            .frame(width: 354, height: 100)
        }
        .navigationTitle("Educators")

    }
    
}

struct LearnerListCard: View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var learner : Learner
    
    var body: some View {
        NavigationLink(destination: EducatorProfile()){
            HStack(spacing: 10){
                ProfileCircleImage(imageURL: learner.firstName!, width: 60, height: 60)

                VStack(alignment: .leading){
                    Text(learner.firstName! + " " + learner.lastName!)
                        .font(.custom("Poppins-Medium", size: 18))
                    Text("Since \(learner.joinedDate!)")
                        .lineLimit(2)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.secondary)
                    
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(10)
            .frame(width: 354, height: 100)
        }
        .navigationTitle("Learners")
        //            .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    EducatorsListCard(educator: Educator(id: "Dummyq", firstName: "rhdgsvdgr", lastName: "hdvsx", about: "hregsdvz", email: "htdfbvsc", password: "grdsc", phoneNumber: "bfdvcsxa", profileImageURL: "ngbdvs"))
}
