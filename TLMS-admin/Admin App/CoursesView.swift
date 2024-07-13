import SwiftUI

struct CoursesView: View {
    @State private var showModal = false
    @State private var navigateToCoursesCreation = false
    @StateObject private var viewModel = CoursesListViewModel()
    @State var selectedTarget: String

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack (alignment: .center){
                    GeometryReader { geometry in
                        ScrollView{
//                            VStack(alignment: .center){
                                if viewModel.courses.isEmpty {
                                    Text("No Courses")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.black))
                                        .opacity(0)
                                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.4)
                                } else {
                                    ForEach(viewModel.courses){
                                        course in
                                        CourseCardView()
                                       
                                    }
                                    .onAppear(){
                                        viewModel.fetchCourses(targetName: selectedTarget)
                                    }
                                }
//                            }
                        }
                    }
                }
                .padding(.horizontal)

                Image("homescreenWave")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showModal.toggle()
                    }) {
                        HStack {
                            Text(selectedTarget)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CourseCreationView(targetName: selectedTarget), isActive: $navigateToCoursesCreation) {
                        Button(action: {
                            navigateToCoursesCreation = true
                            print("Plus button tapped")
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .navigationBarHidden(false)
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $showModal) {
                DomainSelectionView(selectedTarget: $selectedTarget, showModal: $showModal)
                    .presentationDetents([.height(270)]) // Adjust the height based on the content
            }
            .onAppear {
                viewModel.fetchCourses(targetName: selectedTarget)
            }
            .onChange(of: selectedTarget) { newTarget in
                viewModel.fetchCourses(targetName: newTarget)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}




import SwiftUI

struct DomainSelectionView: View {
    @Binding var selectedTarget: String
    @Binding var showModal: Bool
    @State var targets: [String] = []
    @State var courseService = CourseServices()

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(targets, id: \.self) { target in
                        Button(action: {
                            selectedTarget = target
                            showModal.toggle()
                        }) {
                            Text(target)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(8)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            allTargets()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    func allTargets() {
        courseService.fetchTargets { fetchedTargets in
            print("Fetched Targets: \(fetchedTargets)")
            self.targets = fetchedTargets
        }
    }
}




class CoursesListViewModel: ObservableObject {
    @Published var courses: [Course] = []
    private let courseService = CourseServices()

    func fetchCourses(targetName: String) {
        courseService.fetchCoursesByTarget(targetName: targetName) { courses, error in
            if let error = error {
                print("Error fetching courses: \(error.localizedDescription)")
                return
            }
            
            if let courses = courses {
                DispatchQueue.main.async {
                    self.courses = courses
                }
            }
        }
    }
}



struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView(selectedTarget: "HAHA! Joker")
    }
}
