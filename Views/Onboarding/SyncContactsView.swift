//
//  SyncContactsView.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/5/24.
//

import SwiftUI

struct SyncContactsView: View {
    @Binding var isOnboarding: Bool
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("onboarding-all-set")
            
            Text("Awesome!")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Continue to start chatting with your friends.")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                isOnboarding = false
            } label: {
                Text("Continue")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 61)

        }
        .padding(.horizontal)
        .onAppear {
            contactsViewModel.getLocalContacts()
        }
        
    }
}

struct SyncContactsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncContactsView(isOnboarding: .constant(true))
    }
}
