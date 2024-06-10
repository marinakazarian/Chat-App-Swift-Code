//
//  swiftui_chatApp.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/5/24.
//

import SwiftUI
import Firebase

@main
struct swiftui_chatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // can pick up changes of instance of view model
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var contactsViewModel = ContactsViewModel()
    @StateObject var chatViewModel = ChatViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(contactsViewModel)
                .environmentObject(chatViewModel)
                .environmentObject(settingsViewModel)
                .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)

        }
    }
    
//    init() {
//        FirebaseApp.configure()
//    }
}
