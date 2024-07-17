import SwiftUI
import AVKit
import Foundation
import PDFKit

struct PublishCourse: View {
    @State var courseService = CourseServices()
    var course: Course
    @State var modules: [String] = []
    @State private var selectedContent: ContentType?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                CoursethumbnailImage(imageURL: course.courseImageURL, width: 354, height: 200)
                Text(course.courseName)
                    .font(.custom("Poppins-SemiBold", size: 24))
                Text(course.courseDescription)
                    .font(.custom("Poppins-Regular", size: 18))
                ModuleSection(course: course, modules: modules, selectedContent: $selectedContent)
            }
            .padding(20)
            .navigationTitle("Course Name")
            .navigationBarTitleDisplayMode(.inline)
            VStack {
                CustomButton(label: "Publish", action: {})
            }
        }
        .onAppear() {
            allModules()
        }
        .sheet(item: $selectedContent) { content in
            switch content {
            case .video(let url):
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
            case .pdf(let url):
                PDFKitView(url: url)
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
            }
        }
    }

    func allModules() {
        courseService.fetchModules(course: course) { modules in
            self.modules = modules
        }
    }
}

enum ContentType: Identifiable {
    case video(URL)
    case pdf(URL)

    var id: UUID {
        return UUID()
    }
}

struct ModuleSection: View {
    @State var courseService = CourseServices()
    var course: Course
    var modules: [String]
    @Binding var selectedContent: ContentType?

    var body: some View {
        ForEach(modules, id: \.self) { module in
            VStack(alignment: .leading) {
                Text(module)
                    .font(.custom("Poppins-SemiBold", size: 18))
                ModuleCard(selectedContent: $selectedContent)
            }
        }
    }
}

struct ModuleCard: View {
    @Binding var selectedContent: ContentType?

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 10) {
                Image("SwiftLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 50)
                Text("Video Title")
                    .font(.custom("Poppins-Medium", size: 18))
                    .lineLimit(1)
                Spacer()
                Button(action: {
                    let baseURL = URL(string: "http://192.168.21.66/videos/")!
                    let url = baseURL.appendingPathComponent("interiAR.mp4")
                    selectedContent = .video(url)
                }) {
                    Text("Review")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(Color("color 1"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 0.8)
                        )
                }
            }
            .frame(width: 354)
            .padding(10)
            Divider()
            // Notes Review Card
            HStack(spacing: 10) {
                Image("SwiftLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 50)
                Text("Notes Title")
                    .font(.custom("Poppins-Medium", size: 18))
                    .lineLimit(1)
                Spacer()
                Button(action: {
                    let baseURL = URL(string: "http://192.168.21.66/notes/")!
                    let url = baseURL.appendingPathComponent("Fundamentals.pdf")
                    selectedContent = .pdf(url)
                }) {
                    Text("Review")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(Color("color 1"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 0.8)
                        )
                }
            }
            .padding(10)
        }
        .background(Color("color 3"))
        .cornerRadius(12)
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

#Preview {
    PublishCourse(course: Course(courseID: UUID(), courseName: "afdsf", courseDescription: "sdfs", assignedEducator: Educator(firstName: "sdfsd", lastName: "sdfsd", about: "sdfsd", email: "fsdf", password: "sdfsdf", phoneNumber: "sdfsd", profileImageURL: "sdfsdf"), target: "fasd", state: "asdfa"))
}
