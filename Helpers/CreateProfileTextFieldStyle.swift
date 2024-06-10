//
//  CreateProfileTextFieldStyle.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/5/24.
//

import Foundation
import SwiftUI

struct CreateProfileTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
            
            configuration
                .foregroundColor(Color("text-textfield"))
                .font(Font.tabBar)
                .padding()
        }
    }
}
