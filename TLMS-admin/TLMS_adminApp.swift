//
//  TLMS_adminApp.swift
//  TLMS-admin
//
//  Created by abcom on 03/07/24.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TLMS_adminApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                if let role = authViewModel.userRole {
                    switch role {
                    case "educator":
                        EducatorHomeScreen()
                            .environmentObject(authViewModel)
                    case "admin":
                        AdminHomeScreen()
                            .environmentObject(authViewModel)
                    case "pendingEducator":
                        PendingEducatorScreen()
                            .environmentObject(authViewModel)
                    default:
                        Text("Unknown role")
                    }
                } else {
                    Text("Loading...")
                }
            } else {
                MainScreenView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
