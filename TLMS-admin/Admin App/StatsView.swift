import SwiftUI
import FirebaseAuth

struct StatsView: View {
    var body: some View {

            ScrollView{
                VStack{
                    Statscard()
                }
                .padding(20)
               
                

            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.automatic)
        
    }
}

#Preview {
    StatsView()
}

struct Statscard: View {
    @State var isRefreshing = false
    @EnvironmentObject var authViewModel: UserAuthentication
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TotalEnrollment()
            CourseEnrollment()
            
            HStack {
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        authViewModel.signOut()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                }) {
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Button(action: {
                    isRefreshing.toggle()
                }) {
                    Image(systemName: "arrow.circlepath")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color("cardBackground"))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct TotalEnrollment: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Total Enrollments")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(Color.primary)
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 12)

                    .fill(Color("color 2"))
                    .frame(height: 100)

                PNGImageView(imageName: "wave2", width: .infinity, height: .infinity)
                    .contrast(colorScheme == .dark ? 12 : 2)
                    .frame(height: 100)
                
                HStack {
                    VStack {
                        Text("Data1")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                            .foregroundColor(Color.primary)
                        
                        Text("Educator")
                            .font(.custom("Poppins-Medium", size: 18))
                            .foregroundColor(Color.primary)
                    }
                    Divider().padding(.bottom,15)
                    VStack {
                        Text("Data2")
                            .font(.custom("Poppins-Bold", size: 24))
                            .frame(width: 177, alignment: .center)
                            .foregroundColor(Color.primary)
                        
                        Text("Learners")
                            .font(.custom("Poppins-Medium", size: 18))
                            .foregroundColor(Color.primary)
                    }
                }
            }
        }
    }}


struct CourseEnrollment: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Courses Enrollments")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(Color.primary)
            
            HStack {
                CoursethumbnailImage(imageURL: "", width: 80, height: 80)
                
                Text("Swift Fundamentals")
                    .font(.custom("Poppins-Medium", size: 20))
                    .frame(maxWidth: 200, alignment: .leading)
                    .foregroundColor(Color.primary)
                    .lineLimit(1)
                
                Spacer()
                
                Text("234")
                    .font(.custom("Poppins-Bold", size: 24))
                    .foregroundColor(Color.primary)
            }
            .padding(10)
            .frame(width: 360, height: 100)
            .background(Color("color2"))
            .cornerRadius(12)
        }
    }
}
