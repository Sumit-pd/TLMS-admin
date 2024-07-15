//
//  CourseUploadView.swift
//  TLMS-admin
//
//  Created by Abcom on 15/07/24.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

struct CourseUpload: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
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
                    
                    Button(action: { uploadModulesToFirestore() }) {
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
    
    func uploadModulesToFirestore() {
        let db = Firestore.firestore()
        let storage = Storage.storage()
        
        for module in modules {
            guard let notesFileName = module.notesFileName, let videoFileName = module.videoFileName else {
                alertMessage = "All files must be selected before uploading."
                showAlert = true
                return
            }
            
            let notesURL = URL(fileURLWithPath: notesFileName)
            let videoURL = URL(fileURLWithPath: videoFileName)
            
            let notesRef = storage.reference().child("notes/\(notesFileName)")
            let videoRef = storage.reference().child("videos/\(videoFileName)")
            
            notesRef.putFile(from: notesURL, metadata: nil) { metadata, error in
                if let error = error {
                    alertMessage = "Failed to upload notes: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                notesRef.downloadURL { url, error in
                    if let error = error {
                        alertMessage = "Failed to get download URL for notes: \(error.localizedDescription)"
                        showAlert = true
                        return
                    }
                    
                    if let notesDownloadURL = url {
                        videoRef.putFile(from: videoURL, metadata: nil) { metadata, error in
                            if let error = error {
                                alertMessage = "Failed to upload video: \(error.localizedDescription)"
                                showAlert = true
                                return
                            }
                            
                            videoRef.downloadURL { url, error in
                                if let error = error {
                                    alertMessage = "Failed to get download URL for video: \(error.localizedDescription)"
                                    showAlert = true
                                    return
                                }
                                
                                if let videoDownloadURL = url {
                                    db.collection("modules").addDocument(data: [
                                        "title": module.title,
                                        "notesURL": notesDownloadURL.absoluteString,
                                        "videoURL": videoDownloadURL.absoluteString
                                    ]) { error in
                                        if let error = error {
                                            alertMessage = "Failed to save module data: \(error.localizedDescription)"
                                            showAlert = true
                                        } else {
                                            alertMessage = "Module data saved successfully."
                                            showAlert = true
                                        }
                                    }
                                }
                            }
                        }
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

            FileUploadView(title: "Upload Notes", fileName: $module.notesFileName, uploadProgress: $module.notesUploadProgress, fileType: .pdf)
                .padding(.bottom, 20)

            FileUploadView(title: "Upload Video", fileName: $module.videoFileName, uploadProgress: $module.videoUploadProgress, fileType: .video)
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
    @Binding var uploadProgress: Double
    var fileType: FileType
    
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
                DocumentPicker(fileName: $fileName, uploadProgress: $uploadProgress)
            } else {
                VideoPicker(fileName: $fileName, uploadProgress: $uploadProgress)
            }
        }
    }
}


struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var fileName: String?
    @Binding var uploadProgress: Double

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedFile = urls.first else { return }
            
            parent.fileName = selectedFile.lastPathComponent
            parent.simulateUpload()
        }
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func simulateUpload() {
        uploadProgress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            uploadProgress += 0.05
            if uploadProgress >= 1.0 {
                timer.invalidate()
            }
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var fileName: String?
    @Binding var uploadProgress: Double
    
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
                    
                    DispatchQueue.main.async {
                        self.parent.fileName = url.lastPathComponent
                        self.parent.simulateUpload()
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
    
    func simulateUpload() {
        uploadProgress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            uploadProgress += 0.05
            if uploadProgress >= 1.0 {
                timer.invalidate()
            }
        }
    }
}



struct CourseUpload_Previews: PreviewProvider {
    static var previews: some View {
        CourseUpload(course: Course(courseID: UUID(), courseName: "rsvd", courseDescription: "sgfs", assignedEducator: Educator(firstName: "bfvdrg", lastName: "Bfdvsc", about: "Bdfvdc", email: "Bfdvsc", password: "Gbfvdcsz", phoneNumber: "BFvd", profileImageURL: "bfdvs"), target: "bdsvac", state: "Bfsdvzcs"))
    }
}


//import SwiftUI
//import FirebaseFirestore
//import FirebaseStorage
//import PhotosUI
//import _AVKit_SwiftUI
//
//struct CourseUpload: View {
//    @State private var selection = 0
//    @State private var module = 1
//    @State private var modules: [Module] = [Module(title: "Module 1: Greetings and Introduction", notesFileName: nil, notesUploadProgress: 0.0, videoFileName: nil, videoUploadProgress: 0.0)]
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack {
//                    HStack {
//                        Image(systemName: "person.fill")
//                        Text("Swift Fundamentals")
//                    }
//                    Picker(selection: $selection, label: Text("Picker")) {
//                        Text("Modules").tag(0)
//                        Text("Quiz").tag(1)
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .colorMultiply(.purple)
//                    .padding(10)
//                    
//                    HStack {
//                        Text("Add Course Contents")
//                            .fontWeight(.bold)
//                        Spacer()
//                        Button(action: { addNewModule() }) {
//                            Text("+ Add Module")
//                        }
//                        .font(.system(size: 12))
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 5)
//                        .padding(8)
//                        .background(Color.purple)
//                        .cornerRadius(5)
//                    }
//                    .padding(10)
//                    
//                    ForEach(modules.indices, id: \.self) { index in
//                        ModuleContent(module: $modules[index])
//                            .background(Color.purple.opacity(0.05))
//                            .cornerRadius(10)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 5)
//                        
//                        if index < modules.count - 1 {
//                            Divider()
//                                .padding(.horizontal, 10)
//                        }
//                    }
//                    
//                    Button(action: {}) {
//                        Text("Save as Draft")
//                    }
//                    .font(.system(size: 12))
//                    .frame(width: 330, height: 25)
//                    .padding(.horizontal, 5)
//                    .padding(8)
//                    .foregroundColor(.black)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 0.8))
//                    .padding(.top, 20)
//                    
//                    Button(action: {
//                        uploadModulesToFirestore()
//                    }) {
//                        Text("Save and Continue")
//                    }
//                    .font(.system(size: 12))
//                    .frame(width: 330, height: 25)
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 5)
//                    .padding(8)
//                    .background(Color.purple)
//                    .cornerRadius(10)
//                    .alert(isPresented: $showAlert) {
//                        Alert(title: Text("Upload Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//                    }
//                }
//                .padding(10)
//            }
//        }
//    }
//    
//    func addNewModule() {
//        module += 1
//        let newModule = Module(title: "Module \(module)", notesFileName: nil, notesUploadProgress: 0.0, videoFileName: nil, videoUploadProgress: 0.0)
//        modules.append(newModule)
//    }
//    
//    func uploadModulesToFirestore() {
//        let db = Firestore.firestore()
//        let storage = Storage.storage()
//        
//        for module in modules {
//            guard let notesFileName = module.notesFileName, let videoFileName = module.videoFileName else {
//                alertMessage = "All files must be selected before uploading."
//                showAlert = true
//                return
//            }
//            
//            let notesURL = URL(fileURLWithPath: notesFileName)
//            let videoURL = URL(fileURLWithPath: videoFileName)
//            
//            let notesRef = storage.reference().child("notes/\(notesFileName)")
//            let videoRef = storage.reference().child("videos/\(videoFileName)")
//            
//            notesRef.putFile(from: notesURL, metadata: nil) { metadata, error in
//                if let error = error {
//                    alertMessage = "Failed to upload notes: \(error.localizedDescription)"
//                    showAlert = true
//                    return
//                }
//                
//                notesRef.downloadURL { url, error in
//                    if let error = error {
//                        alertMessage = "Failed to get download URL for notes: \(error.localizedDescription)"
//                        showAlert = true
//                        return
//                    }
//                    
//                    if let notesDownloadURL = url {
//                        videoRef.putFile(from: videoURL, metadata: nil) { metadata, error in
//                            if let error = error {
//                                alertMessage = "Failed to upload video: \(error.localizedDescription)"
//                                showAlert = true
//                                return
//                            }
//                            
//                            videoRef.downloadURL { url, error in
//                                if let error = error {
//                                    alertMessage = "Failed to get download URL for video: \(error.localizedDescription)"
//                                    showAlert = true
//                                    return
//                                }
//                                
//                                if let videoDownloadURL = url {
//                                    db.collection("modules").addDocument(data: [
//                                        "title": module.title,
//                                        "notesURL": notesDownloadURL.absoluteString,
//                                        "videoURL": videoDownloadURL.absoluteString
//                                    ]) { error in
//                                        if let error = error {
//                                            alertMessage = "Failed to save module data: \(error.localizedDescription)"
//                                            showAlert = true
//                                        } else {
//                                            alertMessage = "Module data saved successfully."
//                                            showAlert = true
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
