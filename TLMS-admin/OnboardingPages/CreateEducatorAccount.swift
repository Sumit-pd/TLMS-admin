import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct CreateAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme // Line 10
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var profilePicture: Image? = nil
    @State private var first: String = ""
    @State private var last: String = ""
    @State private var about: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var isLoading = false
    @State private var navigateToPendingEdu = false
    @State private var registrationDone = false
    @State private var isFirstNameValid = false
    @State private var isLastNameValid = false
    @State private var isEmailValid = false
    @State private var isNewPasswordValid = false
    @State private var isConfirmPasswordValid = false
    @State private var isAboutValid = false
    @State private var isPhoneNumberValid = false

    var body: some View {
        ZStack(alignment: .bottom) {
            PNGImageView(imageName: "Waves", width: 394, height: 194)
            VStack(spacing: 20) {
                ScrollView {
                    VStack {
                        Button(action: {
                            showImagePicker = true
                        }) {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 2))
                                    .padding()
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.primary, lineWidth: 2))
                                    .padding()
                                    .accessibilityLabel("Profile Picture")
                                    .accessibilityAddTraits(.isButton)
                            }
                        }

                        HStack {
                            TextField("First Name", text: $first)
                                .padding()
                                .frame(height: 55)
                                .background(Color(colorScheme == .dark ? .black : .white)) // Line 60
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.secondary, lineWidth: 1)
                                )
                                .foregroundColor(Color.primary)
                                .onChange(of: first) { _, newVal in
                                    isFirstNameValid = validateName(name: newVal)
                                }

                            TextField("Last Name", text: $last)
                                .padding()
                                .frame(height: 55)
                                .background(Color(colorScheme == .dark ? .black : .white)) // Line 75
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.secondary, lineWidth: 1)
                                )
                                .foregroundColor(Color.primary)
                                .onChange(of: last) { _, newVal in
                                    isLastNameValid = validateName(name: newVal)
                                }
                        }
                        .padding(.horizontal, 17)

                        HStack {
                            Spacer()
                            if (!isFirstNameValid && first != "") || (!isLastNameValid && last != "") {
                                Text("Name should only contain alphabets [2-20]")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else if first == last && first != "" && last != "" {
                                Text("Names should not match.")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else {
                                Text("Name should only contain alphabets")
                                    .font(.caption)
                                    .foregroundColor(Color(colorScheme == .dark ? .gray : .white)) // Line 95
                                    .padding(.trailing, 15)
                                    .opacity(0)
                            }
                        }

                        CustomTextField(placeholder: "About", text: $about)
                            .onChange(of: about) { _, newVal in
                                isAboutValid = validateAbout(about: newVal)
                            }

                        HStack {
                            Spacer()
                            if !isAboutValid && about != "" {
                                Text("Character Limit is 255")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else {
                                Text("Character Limit is 255")
                                    .font(.caption)
                                    .foregroundColor(Color(colorScheme == .dark ? .gray : .white)) // Line 111
                                    .padding(.trailing, 15)
                                    .opacity(0)
                            }
                        }

                        CustomTextField(placeholder: "Phone Number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .onChange(of: phoneNumber) { _, newVal in
                                isPhoneNumberValid = validatePhoneNumber(newVal)
                            }

                        HStack {
                            Spacer()
                            if phoneNumber.hasPrefix("0") {
                                Text("Phone number can not start with 0")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else if !isPhoneNumberValid && phoneNumber != "" {
                                Text("Phone number must contain 10 digits.")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else {
                                Text("Phone number can only contain 10 digits.")
                                    .font(.caption)
                                    .foregroundColor(Color(colorScheme == .dark ? .gray : .white)) // Line 135
                                    .padding(.trailing, 15)
                                    .opacity(0)
                            }
                        }

                        CustomTextField(placeholder: "Email", text: $email)
                            .onChange(of: email) { _, newVal in
                                isEmailValid = validateEmail(email: newVal)
                            }

                        HStack {
                            Spacer()
                            if !isEmailValid && email != "" {
                                Text("Invalid email format")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else {
                                Text("Invalid email format")
                                    .font(.caption)
                                    .foregroundColor(Color(colorScheme == .dark ? .gray : .white)) // Line 151
                                    .padding(.trailing, 15)
                                    .opacity(0)
                            }
                        }

                        CustomSecureField(placeholder: "New Password", text: $newPassword)
                            .onChange(of: newPassword) { _, newVal in
                                isNewPasswordValid = validatePassword(newVal)
                            }

                        HStack {
                            Spacer()
                            if !isNewPasswordValid && newPassword != "" {
                                Text("Password must have uppercase, digit & special charcater")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else {
                                Text("Password must have uppercase, digit & special charcater")
                                    .font(.caption)
                                    .foregroundColor(Color(colorScheme == .dark ? .gray : .white)) // Line 168
                                    .padding(.trailing, 15)
                                    .opacity(0)
                            }
                        }

                        CustomSecureField(placeholder: "Confirm Password", text: $confirmPassword)
                            .onChange(of: confirmPassword) { _, newVal in
                                isConfirmPasswordValid = validatePassword(newVal)
                            }

                        HStack {
                            Spacer()
                            if !isConfirmPasswordValid && confirmPassword != "" {
                                Text("Password must have uppercase, digit & special charcater")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else if newPassword != confirmPassword {
                                Text("Passwords do not match.")
                                    .font(.caption)
                                    .foregroundColor(Color.red)
                                    .padding(.trailing, 35)
                            } else {
                                Text("Password must have uppercase, digit & special charcater")
                                    .font(.caption)
                                    .foregroundColor(Color(colorScheme == .dark ? .gray : .white)) // Line 185
                                    .padding(.trailing, 15)
                                    .opacity(0)
                            }
                        }

                        CustomButton(label: "Register", action: {
                            if isFirstNameValid && isLastNameValid && isPhoneNumberValid && isEmailValid && isAboutValid && isNewPasswordValid && isConfirmPasswordValid {
                                register()
                                if registrationDone {
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    alertMessage = "Enter all fields correctly"
                                    showAlert = true
                                }
                            }
                        })
                        .padding(.bottom, 20)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .navigationTitle("Create Account")
        .ignoresSafeArea(edges: .bottom)
    }

    func register() {
        guard newPassword == confirmPassword else {
            alertMessage = "Passwords do not match"
            showAlert = true
            return
        }

        isLoading = true
        if let image = selectedImage {
            uploadProfileImage(image: image) { url in
                guard let url = url else {
                    alertMessage = "Failed to upload profile image"
                    showAlert = true
                    isLoading = false
                    return
                }
                savePendingEducatorData(profileImageUrl: url.absoluteString)
            }
        } else {
            savePendingEducatorData(profileImageUrl: nil)
        }
    }

    func uploadProfileImage(image: UIImage, completion: @escaping (URL?) -> Void) {
        let storageRef = Storage.storage().reference().child("profile_images").child(UUID().uuidString + ".jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(nil)
            return
        }
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                completion(url)
            }
        }
    }

    func savePendingEducatorData(profileImageUrl: String?) {
        let educatorInfo: Educator = Educator(firstName: first, lastName: last, about: about, email: email, password: confirmPassword, phoneNumber: phoneNumber, profileImageURL: profileImageUrl ?? "")
        Firestore.firestore().collection("Pending-Educators").document(email).setData(educatorInfo.toDictionary()) { error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                alertMessage = "Registration request submitted successfully!"
                showAlert = true
                isLoading = false
                registrationDone = true
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
