//
//  SettingsViewModel.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/10/24.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    // behaves as @Published
    @AppStorage(Constants.DarkModeKey) var isDarkMode = false
    
    var databaseService = DatabaseService()
    
    func deactivateAccount(completion: @escaping () -> Void) {
        databaseService.deactivateAccount {
            completion()
        }
    }
}
