import SwiftUI
import AVKit
import UIKit
import PhotosUI
import Firebase

struct CourseUploadFile: View {
    @ObservedObject var firebaseFetch = FirebaseFetch()
    @State var courseService = CourseServices()
    @Environment(\.presentationMode) var presentationMode
    @State private var selection = 0
    @State private var module = 1
    @State private var modules: [Module] = [Module(title: "Module 1: Greetings and Introduction", notesFileName: nil, notesUploadProgress: 0.0, videoFileName: nil, videoUploadProgress: 0.0)]
    @State private var showingVideoPicker = false
    @State private var videoURL: URL?
    @State private var showingDocumentPicker = false
    @State private var documentURL: URL?
    @State var course : Course

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "person.fill")
                        Text(course.courseName)
                    }
                    Picker(selection: $selection, label: Text("Picker")) {
                        Text("Modules").tag(0)
                        Text("Quiz").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(.purple)
                    .padding(10)

                    HStack {
                        Text("Add Course Contents")
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: { addNewModule() }) {
                            Text("+ Add Module")
                        }
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .padding(8)
                        .background(Color.purple)
                        .cornerRadius(5)
                    }
                    .padding(10)

                    ForEach(modules.indices, id: \.self) { index in
                        ModuleContent(module: $modules[index], course: course)
                            .background(Color.purple.opacity(0.05))
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)

                        if index < modules.count - 1 {
                            Divider()
                                .padding(.horizontal, 10)
                        }
                    }

                    Button(action: {}) {
                        Text("Save as Draft")
                    }
                    .font(.system(size: 12))
                    .frame(width: 330, height: 25)
                    .padding(.horizontal, 5)
                    .padding(8)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 0.8))
                    .padding(.top, 20)

                    CustomButton(label: "Mark as Complete", action: {
                        courseService.updateCourseState(course: course, newState: "completed") {
                            error in
                            print("Error")
                        }
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                .padding(10)
            }
        }
    }

    func addNewModule() {
        module += 1
        let newModule = Module(title: "Module \(module)", notesFileName: nil, notesUploadProgress: 0.0, videoFileName: nil, videoUploadProgress: 0.0)
        modules.append(newModule)
    }
}

// Define the ModuleContent view
struct ModuleContent: View {
    @Binding var module: Module
    var course : Course

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Module Title", text: $module.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 10)

            FileUploadView(title: "Upload Notes", fileName: $module.notesFileName, uploadProgress: $module.notesUploadProgress, fileType: .pdf, course: course, module : module)
                .padding(.bottom, 20)

            FileUploadView(title: "Upload Video", fileName: $module.videoFileName, uploadProgress: $module.videoUploadProgress, fileType: .video, course: course, module : module)
        }
        .padding()
    }
}

// Define the FileType enum
enum FileType {
    case pdf
    case video
}

// Define the FileUploadView view
struct FileUploadView: View {
    var title: String
    @Binding var fileName: String?
    @Binding var uploadProgress: Double
    var fileType: FileType
    var course : Course
    var module : Module

    @State private var showFilePicker = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 10)

            if let fileName = fileName {
                HStack {
                    Text(fileName)
                    Spacer()
                    ProgressView(value: uploadProgress)
                        .progressViewStyle(LinearProgressViewStyle())
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            } else {
                VStack {
                    Button(action: { showFilePicker.toggle() }) {
                        VStack {
                            Image(systemName: "icloud.and.arrow.up")
                                .font(.largeTitle)
                            Text(fileType == .pdf ? "Browse Notes (Max 2MB, PDF only)" : "Browse Video")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
            }
        }
        .sheet(isPresented: $showFilePicker) {
            if fileType == .pdf {
                DocumentPicker(fileName: $fileName, uploadProgress: $uploadProgress, course: course, module : module)
            } else {
                VideoPicker(fileName: $fileName, uploadProgress: $uploadProgress, course: course, module : module)
            }
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var fileName: String?
    @Binding var uploadProgress: Double
    var course : Course
    var module : Module

    class Coordinator: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedFileURL = urls.first else { return }

            let fileSize = try? selectedFileURL.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0

            if let fileSize = fileSize, fileSize <= 2 * 1024 * 1024 {
                parent.fileName = selectedFileURL.lastPathComponent
                parent.uploadDocument(url: selectedFileURL)
            } else {
                // Handle file size exceeding limit
                parent.fileName = "File size exceeds 2MB limit"
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func uploadDocument(url: URL) {
        let uploadURL = URL(string: "http://192.168.21.66/upload.php")!
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"\(url.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/pdf\r\n\r\n".data(using: .utf8)!)
        body.append(try! Data(contentsOf: url))
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            guard let data = data, error == nil else {
                print("Upload error: \(String(describing: error))")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("Response: \(responseString ?? "No response")")

            DispatchQueue.main.async {
                self.simulateUpload()
            }
        }.resume()
    }

    func simulateUpload() {
        uploadProgress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            uploadProgress += 0.05
            if uploadProgress >= 1.0 {
                timer.invalidate()
                uploadDocumentToFirebase()
            }
        }
    }

    func uploadDocumentToFirebase() {
        let db = Firestore.firestore()
        let moduleName = "Module \(UUID().uuidString)"
        
        db.collection("Courses").document(course.courseName).collection("Modules").document(module.title).setData([
            "notesFileName": fileName ?? ""
        ], merge: true) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var fileName: String?
    @Binding var uploadProgress: Double
    var course : Course
    var module : Module

    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        var parent: VideoPicker

        init(parent: VideoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)

            guard let provider = results.first?.itemProvider else { return }

            if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                    guard let url = url else { return }

                    // Copy the file to a temporary directory
                    let tempDirectory = FileManager.default.temporaryDirectory
                    let tempURL = tempDirectory.appendingPathComponent(url.lastPathComponent)

                    do {
                        if FileManager.default.fileExists(atPath: tempURL.path) {
                            try FileManager.default.removeItem(at: tempURL)
                        }
                        try FileManager.default.copyItem(at: url, to: tempURL)

                        DispatchQueue.main.async {
                            self.parent.fileName = tempURL.lastPathComponent
                            self.parent.uploadVideo(url: tempURL)
                        }
                    } catch {
                        print("Error copying file: \(error)")
                    }
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .videos
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func uploadVideo(url: URL) {
        let uploadURL = URL(string: "http://192.168.21.66/upload.php")!
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"fileToUpload\"; filename=\"\(url.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
        body.append(try! Data(contentsOf: url))
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            guard let data = data, error == nil else {
                print("Upload error: \(String(describing: error))")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("Response: \(responseString ?? "No response")")

            DispatchQueue.main.async {
                self.simulateUpload()
            }
        }.resume()
    }

    func simulateUpload() {
        uploadProgress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            uploadProgress += 0.05
            if uploadProgress >= 1.0 {
                timer.invalidate()
                uploadVideoToFirebase()
            }
        }
    }

    func uploadVideoToFirebase() {
        let db = Firestore.firestore()
        let moduleName = "Module \(UUID().uuidString)"
        
        db.collection("Courses").document(course.courseName).collection("Modules").document(module.title).setData([
            "videoFileName": fileName ?? ""
        ], merge: true) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

// Define the Module struct
struct Module: Identifiable {
    let id = UUID()
    var title: String
    var notesFileName: String?
    var notesUploadProgress: Double
    var videoFileName: String?
    var videoUploadProgress: Double
}


// Define the CourseUpload_Previews struct
struct CourseUpload_Previews: PreviewProvider {
    static var previews: some View {
        let course = Course(courseID: UUID(), courseName: "Swift Fundamentals", courseDescription: "Discover SwiftUI's power in our immersive course! fcec ercerc reerc rfv fve", assignedEducator: Educator(firstName: "rgsdvc", lastName: "thegrsec", about: "trebsvec", email: "tbrsvdac", password: "tbdvsc", phoneNumber: "trbrvsda", profileImageURL: "brvsdc"), target: "tbvsdc", state: "bfvsd")
        CourseUploadFile(course: course)
    }
}
