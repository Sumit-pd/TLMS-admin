import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct CourseCreationView: View {
    @State private var courseTitle: String = ""
    @State private var courseDescription: String = ""
    @State private var selectedEducator: Educator? = nil
    @State private var courseImage: UIImage? = nil
    @State private var releaseDate: Date = Date()
    @State private var isTitle: Bool = false
    @State private var isDescription: Bool = false
    @State private var showEducatorPicker: Bool = false
    @State private var showImagePicker: Bool = false
    @State var courseService = CourseServices()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme // Add this line to access color scheme
    
    var targetName: String

    var body: some View {

//        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Add Course Image")
                        .font(.headline)
                    
                    Button(action: {
                        showImagePicker = true
                    }) {
                        HStack {
                            if let image = courseImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 254 ,height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                Image(systemName: "square.and.arrow.up")
                                Text("Add file")
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $courseImage)
                    }

                    EditableFieldView(title: "Course Title", text: $courseTitle, placeholder: "Enter Course Title")
                        .onChange(of: courseTitle) { _, newVal in
                            isTitle = validateTitle(title: newVal)
                         }
                    HStack {
                        Spacer()
                        if !isTitle && courseTitle != "" {
                            Text("Title should contain max 30 characters")
                                .font(.caption2)
                                .foregroundColor(.red)
                                .padding(.trailing, 35)
                        } else {
                            Text("Title should contain max 30 characters")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(.trailing, 15)
                                .opacity(0)
                        }
                    }

                    EditableFieldView(title: "Course Description", text: $courseDescription, placeholder: "Enter Course Description", isMultiline: true)
                        .onChange(of: courseDescription) { _, newVal in
                            isDescription = validateAbout(about: newVal)
                        }
                    HStack {
                        Spacer()
                        if !isDescription && courseDescription != "" {
                            Text("Character Limit is 255")
                                .font(.caption2)
                                .foregroundColor(.red)
                                .padding(.trailing, 35)
                        } else {
                            Text("Character Limit is 255")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(.trailing, 15)
                                .opacity(0)
                        }
                    }


                    Text("Release Date")
                        .font(.headline)
                    DatePicker("Select Date", selection: $releaseDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        

                    Text("Assign Educator")
                        .font(.headline)

                    Button(action: {
                        showEducatorPicker = true
                    }) {
                        HStack {
                            if let educator = selectedEducator {
                                HStack (spacing: 10){
                                    ProfileCircleImage(imageURL: educator.profileImageURL, width: 35, height: 35)
                                    Text(educator.firstName + " " + educator.lastName)
                                        .font(.subheadline)
                                        .background(Color(.white))
                                }
                                .background(Color(.white))
                            } else {
                                Text("Select Educator")
                                    .font(.subheadline)
                                    .foregroundColor(colorScheme == .dark ? .white : .black) // Adjust text color for dark mode
                            }
                        }                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .sheet(isPresented: $showEducatorPicker) {
                    EducatorPickerView(selectedEducator: $selectedEducator)
                }

//                CustomButton(label: "Create Course", action: {
//                    uploadCourseImage { url in
//                        let courseData: Course = Course(courseID: UUID(), courseName: courseTitle, courseDescription: courseDescription, courseImageURL: url!.absoluteString, releaseDate: releaseDate, assignedEducator: selectedEducator!, target: targetName, state: "created")
//                        courseService.createCourse(course: courseData) { error in
//                            if let _ = error {
//                                print("Error uploading the course.")
//                            }
//                        }
//                    }
//                    presentationMode.wrappedValue.dismiss()
//                })
            }
            .padding(20)
        }
//        .background(colorScheme == .dark ? Color.black : Color.white) // Adjust background color for dark mode
//        .navigationTitle("Course Creation")
//        .navigationBarTitleDisplayMode(.inline)
    }

//    private func uploadCourseImage(completion: @escaping (URL?) -> Void) {
//        guard let image = courseImage else {
//            completion(nil)
//            return
//        }
//
//        let storageRef = Storage.storage().reference().child("course_title_images").child(UUID().uuidString + ".jpg")
//        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
//            completion(nil)
//            return
//        }
//
//        storageRef.putData(imageData, metadata: nil) { metadata, error in
//            if let error = error {
//                print("Error uploading image: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//
//            storageRef.downloadURL { url, error in
//                if let error = error {
//                    print("Error getting download URL: \(error.localizedDescription)")
//                    completion(nil)
//                    return
//                }
//
//                completion(url)
//            }
//        }
//    }


struct EditableFieldView: View {
    var title: String
    @Binding var text: String
    var placeholder: String
    var isMultiline: Bool = false
    @Environment(\.colorScheme) var colorScheme // Add this line to access color scheme

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Adjust text color for dark mode
                Spacer()
            }

            if isMultiline {
                TextEditor(text: $text)
                    .frame(height: 80)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
    }
}

struct EducatorPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedEducator: Educator?
    @State private var educators: [Educator] = []
    @ObservedObject var firebaseFetch = FirebaseFetch()
    @State private var searchText: String = ""
    @Environment(\.colorScheme) var colorScheme // Add this line to access color scheme

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
                    .onChange(of: searchText) {
                        firebaseFetch.searchText = searchText
                    }

                List {
                    ForEach(firebaseFetch.educators) { educator in
                        Button(action: {
                            selectedEducator = educator
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                ProfileCircleImage(imageURL: educator.profileImageURL, width: 40, height: 40)
                                Text(educator.firstName + " " + educator.lastName)
                                    .font(.headline)
                                    .foregroundColor(colorScheme == .dark ? .white : .black) // Adjust text color for dark mode
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(colorScheme == .dark ? .white : .black) // Adjust icon color for dark mode
                            }
                            .onAppear {
                                educators = firebaseFetch.educators
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Educator")
            .onAppear(perform: firebaseFetch.fetchEducators)
            .background(colorScheme == .dark ? Color.black : Color.white) // Adjust background color for dark mode
        }
    }
}

struct CourseCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCreationView(targetName: "Dummy")
    }
}
