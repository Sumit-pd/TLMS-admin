import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


struct CourseUpload: View {
    @State var course: Course
    @State private var selection = 0
    @State private var module = 1
    @State private var modules: [Module] = [
        Module(
            title: "Module 1: Greetings and Introduction",
            notesFileName: nil,
            notesUploadProgress: 0.0,
            videoFileName: nil,
            videoUploadProgress: 0.0,
            notesURL: nil,
            videoURL: nil
        )
    ]
    @State private var isUploading = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        ProfileCircleImage(imageURL: course.courseImageURL, width: 40, height: 40)
                        Text(course.courseName)
                    }
                    Picker(selection: $selection, label: Text("Picker")) {
                        Text("Modules").tag(0)
                        Text("Quiz").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
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
                        ModuleContent(module: $modules[index])
                            .background(Color.purple.opacity(0.05))
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                        
                        if index < modules.count - 1 {
                            Divider()
                                .padding(.horizontal, 10)
                        }
                    }
                    
                    Button(action: { uploadCourseModules() }) {
                        if isUploading {
                            ProgressView()
                        } else {
                            Text("Mark as complete")
                        }
                    }
                    .font(.system(size: 12))
                    .frame(width: 330, height: 25)
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(8)
                    .background(Color.purple)
                    .cornerRadius(10)
                }
                .padding(10)
            }
        }
    }

    func addNewModule() {
        module += 1
        let newModule = Module(
            title: "Module \(module)",
            notesFileName: nil,
            notesUploadProgress: 0.0,
            videoFileName: nil,
            videoUploadProgress: 0.0
        )
        modules.append(newModule)
    }
    
    func uploadCourseModules() {
        isUploading = true
        
        let db = Firestore.firestore()
        let courseRef = db.collection("Courses").document(course.courseName)
        let storageRef = Storage.storage().reference()

        let dispatchGroup = DispatchGroup()
        
        for moduleIndex in modules.indices {
            dispatchGroup.enter()
            
            let module = modules[moduleIndex]
            let moduleRef = courseRef.collection("Modules").document(module.title)

            var moduleData: [String: Any] = [
                "title": module.title,
                "notesFileName": module.notesFileName ?? "",
                "videoFileName": module.videoFileName ?? ""
            ]
            
            let filesToUpload = [module.notesURL, module.videoURL].compactMap { $0 }
            
            if filesToUpload.isEmpty {
                moduleRef.setData(moduleData) { error in
                    if let error = error {
                        print("Error setting module data: \(error.localizedDescription)")
                    }
                    dispatchGroup.leave()
                }
            } else {
                var uploadCount = filesToUpload.count
                
                if let notesURL = module.notesURL {
                    let notesFileRef = storageRef.child("course_files/\(course.courseID.uuidString)/\(notesURL.lastPathComponent)")
                    uploadFile(to: notesFileRef, fileURL: notesURL) { url in
                        guard let url = url else {
                            dispatchGroup.leave()
                            return
                        }
                        print("Generated URL : - \(url)")
                        moduleData["notesFileURL"] = url.absoluteString
                        uploadCount -= 1
                        if uploadCount == 0 {
                            moduleRef.setData(moduleData) { error in
                                if let error = error {
                                    print("Error setting module data: \(error.localizedDescription)")
                                }
                                dispatchGroup.leave()
                            }
                        }
                    }
                }

                if let videoURL = module.videoURL {
                    let videoFileRef = storageRef.child("course_files/\(course.courseID.uuidString)/\(videoURL.lastPathComponent)")
                    uploadFile(to: videoFileRef, fileURL: videoURL) { url in
                        guard let url = url else {
                            dispatchGroup.leave()
                            return
                        }
                        moduleData["videoFileURL"] = url.absoluteString
                        uploadCount -= 1
                        if uploadCount == 0 {
                            moduleRef.setData(moduleData) { error in
                                if let error = error {
                                    print("Error setting module data: \(error.localizedDescription)")
                                }
                                dispatchGroup.leave()
                            }
                        }
                    }
                }

            }
        }
        
        dispatchGroup.notify(queue: .main) {
            isUploading = false
            print("All modules uploaded.")
        }
    }

    func uploadFile(to storageRef: StorageReference, fileURL: URL, completion: @escaping (URL?) -> Void) {
        print(fileURL)
        print(storageRef)
        let uploadTask = storageRef.putFile(from: fileURL, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading file: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(nil)
                } else {
                    print("Download completed successfully.")
                    completion(url)
                }
            }
        }

        uploadTask.observe(.progress) { snapshot in
            let progress = Double(snapshot.progress?.completedUnitCount ?? 0) / Double(snapshot.progress?.totalUnitCount ?? 0)
            DispatchQueue.main.async {
                if let index = modules.firstIndex(where: { $0.notesFileName == fileURL.lastPathComponent || $0.videoFileName == fileURL.lastPathComponent }) {
                    if fileURL.lastPathComponent == modules[index].notesFileName {
                        modules[index].notesUploadProgress = progress
                    } else if fileURL.lastPathComponent == modules[index].videoFileName {
                        modules[index].videoUploadProgress = progress
                    }
                }
            }
        }
    }

}

struct ModuleContent: View {
    @Binding var module: Module

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Module Title", text: $module.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 10)

            FileUploadView(title: "Upload Notes", fileName: $module.notesFileName, fileURL: $module.notesURL, uploadProgress: $module.notesUploadProgress, fileType: .pdf)
                .padding(.bottom, 20)

            FileUploadView(title: "Upload Video", fileName: $module.videoFileName, fileURL: $module.videoURL, uploadProgress: $module.videoUploadProgress, fileType: .video)
        }
        .padding()
    }
}

enum FileType {
    case pdf
    case video
}

struct FileUploadView: View {
    var title: String
    @Binding var fileName: String?
    @Binding var fileURL: URL?
    @Binding var uploadProgress: Double
    var fileType: FileType
    
    @State private var showFilePicker = false
    @State private var isUploading = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 10)
            
            if let fileName = fileName {
                HStack {
                    Text(fileName)
                        .foregroundColor(isUploading ? .gray : .green)
                    Spacer()
                    if isUploading {
                        ProgressView(value: uploadProgress)
                            .progressViewStyle(LinearProgressViewStyle())
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
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
                DocumentPicker(fileName: $fileName, fileURL: $fileURL)
            } else {
                VideoPicker(fileName: $fileName, fileURL: $fileURL)
            }
        }
    }
}


struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var fileName: String?
    @Binding var fileURL: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) { }

    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedFileURL = urls.first else { return }
            parent.fileName = selectedFileURL.lastPathComponent
            parent.fileURL = selectedFileURL
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var fileName: String?
    @Binding var fileURL: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .videos
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: VideoPicker

        init(_ parent: VideoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider, provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) else { return }
            
            provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                guard let url = url else { return }
                let fileName = url.lastPathComponent
                let tempDir = FileManager.default.temporaryDirectory
                let tempFile = tempDir.appendingPathComponent(fileName)
                
                do {
                    try FileManager.default.copyItem(at: url, to: tempFile)
                    DispatchQueue.main.async {
                        self.parent.fileName = fileName
                        self.parent.fileURL = tempFile
                    }
                } catch {
                    print("Failed to copy file to temp directory: \(error.localizedDescription)")
                }
            }
        }
    }
}



struct CourseUpload_Previews: PreviewProvider {
    static var previews: some View {
        CourseUpload(course: Course(courseID: UUID(), courseName: "rsvd", courseDescription: "sgfs", assignedEducator: Educator(firstName: "bfvdrg", lastName: "Bfdvsc", about: "Bdfvdc", email: "Bfdvsc", password: "Gbfvdcsz", phoneNumber: "BFvd", profileImageURL: "bfdvs"), target: "bdsvac", state: "Bfsdvzcs"))
    }
}
