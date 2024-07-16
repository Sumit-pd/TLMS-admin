//
//  TLMS_adminApp.swift
//  TLMS-admin
//
//  Created by abcom on 03/07/24.
//

import SwiftUI
import Firebase

import SwiftUI
import Firebase

@main
struct TLMS_adminApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userAuth = UserAuthentication()

    var body: some Scene {
        WindowGroup {
            CheckUserRole()
//            SlideScreenView()
                .environmentObject(userAuth)
                .onAppear {
                    userAuth.checkUserStatus()
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
