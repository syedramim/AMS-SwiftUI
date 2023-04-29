//
//  AnimeMangaStackApp.swift
//  AnimeMangaStack
//
//  Created by Kaneis Zontanos on 4/22/23.
//

import SwiftUI
import FirebaseCore


//Code for the firebase stuff
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AnimeMangaStackApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var profileVM = ProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(profileVM)
        }
    }
}
