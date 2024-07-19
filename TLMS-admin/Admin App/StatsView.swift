import SwiftUI
import FirebaseAuth

struct StatsView: View {

    @EnvironmentObject var authViewModel: UserAuthentication
    @ObservedObject var firebaseFetch = FirebaseFetch()
    
    var body: some View {
           
                ScrollView {
                    VStack {
                        Statscard()
                    }
                    .padding(20)
                }
                .navigationTitle("Account")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            do {
                                try Auth.auth().signOut()
                                authViewModel.signOut()
                            } catch let signOutError as NSError {
                                print("Error signing out: %@", signOutError)
                            }
                        }) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.title3)
                                .foregroundColor(Color("color 1"))
                        }
                    }
                }
            
        }
}

#Preview {
    StatsView()
}

struct Statscard: View {

    
    @ObservedObject var firebaseFetch = FirebaseFetch()

    @State var isRefreshing = false
    @EnvironmentObject var authViewModel: UserAuthentication
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TotalEnrollment()
            CourseEnrollment()

//            HStack {
//                Button(action: {
//                    do {
//                        try Auth.auth().signOut()
//                        authViewModel.signOut()
//                    } catch let signOutError as NSError {
//                        print("Error signing out: %@", signOutError)
//                    }
//                }) {
//                    Text("Sign Out")
//
//                        .foregroundColor(.blue)
//                }
//                .padding()
//                Button(action : {
//                    isRefreshing.toggle()
//                }) {
//                    Image(systemName: "arrow.circlepath")
//                }
//            }

        }
        .padding()
        .background(Color("cardBackground"))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct TotalEnrollment: View {

    
    @ObservedObject var firebaseFetch = FirebaseFetch()

    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Total Enrollments")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(Color.primary)
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 12)
                  
                    .fill(Color("color 2"))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 100,maxHeight: 100)

//                
//                    PNGImageView(imageName: "wave2", width: .infinity, height: .infinity)
//                        .contrast(colorScheme == .dark ? 12 : 2)
//                    .frame(height: 100)
                
                    
                
                HStack {
                    VStack {
                        Text("\(firebaseFetch.educators.count)")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                            .foregroundColor(Color.primary)
                        
                        Text("Educator")
                            .font(.custom("Poppins-Medium", size: 18))
                            .foregroundColor(Color.primary)
                    }
                    Divider().padding(.bottom,15)
                    VStack {
                        Text("\(firebaseFetch.learners.count)")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                            .foregroundColor(Color.primary)
                        
                        Text("Learners")
                            .font(.custom("Poppins-Medium", size: 18))
                            .foregroundColor(Color.primary)
                    }
                }

                .onAppear() {
                    firebaseFetch.fetchLearners()
                    firebaseFetch.fetchEducators()
                }
                
            }.frame(height: 100)

        }
    }}


struct CourseEnrollment : View {
    
    @State var courseService  = CourseServices()
    @ObservedObject var firebaseFetch = FirebaseFetch()


    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Publish courses")
                .font(.custom("Poppins-SemiBold", size: 18))

            VStack{
                ForEach(firebaseFetch.courses.filter{$0.state == "published"}) {
                    course in
                    CustomCard(course: course)
                }
            }
                .onAppear() {
                    firebaseFetch.fetchCourses()
                }
            }

        
        }
    }


struct CustomCard : View {
    
    @ObservedObject var firebaseFetch = FirebaseFetch()
    var course : Course
    var body: some View {
        HStack{
            CoursethumbnailImage(imageURL: course.courseImageURL, width: 80, height: 80)
            Text(course.courseName)
                .font(.custom("Poppins-Medium", size: 20))
                .frame(maxWidth: 200, alignment: .leading)
                .lineLimit(1)
            Spacer()
            Text("\(course.numberOfStudentsEnrolled ?? 0)")
                .font(.custom("Poppins-Bold", size: 24))
            
        }
        .padding(10)
        .frame(width: 360, height: 100)
        .background(Color("color 2"))
    .cornerRadius(12)
    }
}
