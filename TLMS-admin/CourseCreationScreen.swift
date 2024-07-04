import SwiftUI

struct CourseCreationView: View {
    @State private var courseTitle: String = "Enter Course Title"
    @State private var courseDescription: String = "Enter Course Description"
    @State private var selectedEducator: String = ""
    @State private var courseImage: UIImage? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Customize Your")
                        .font(.headline)
                        .padding(.top)

                    EditableFieldView(title: "Course Title", text: $courseTitle, placeholder: "Enter Course Title")
                        
                    EditableFieldView(title: "Course Description", text: $courseDescription, placeholder: "Enter Course Description", isMultiline: true)
                    
                    Text("Assign Educator")
                        .font(.headline)

                    Picker("Course Description", selection: $selectedEducator) {
                        Text("Educator 1").tag("Educator 1")
                        Text("Educator 2").tag("Educator 2")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(width: 100,height: 30)
                    Text("Add Course Image")
                        .font(.headline)
                    
                    Button(action: {
                        // Action to add file
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Add file")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Action to create course
                    }) {
                        Text("Create Course")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Course Creation")
            .navigationBarItems(leading: Button(action: {
                // Action for back button
            }) {
                Text("Back")
            })
        }
    }
}

struct EditableFieldView: View {
    var title: String
    @Binding var text: String
    var placeholder: String
    var isMultiline: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Button(action: {
                    // Action to edit
                }) {
                    Text("Edit \t")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
            }
            
            if isMultiline {
                TextEditor(text: $text)
                    .frame(height: 100)
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

#Preview {
    CourseCreationView()
}
