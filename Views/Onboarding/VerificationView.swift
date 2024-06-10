//
//  VerificationView.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/5/24.
//

import SwiftUI
import Combine

struct VerificationView: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel

    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool

    @State var verificationcode = ""
    @State var isButtonDisabled = false
    @State var isErrorLabelVisible = false
    
    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter the 6-digit verification code we sent to your device.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("", text: $verificationcode)
                        .foregroundColor(Color("text-textfield"))
                        .font(Font.bodyParagraph)
                        .onReceive(Just(verificationcode)) { _ in
                            TextHelper.limitText(&verificationcode, 6)
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        verificationcode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                    
                        
                        
                }
                .padding()
                
            }
            .padding(.top, 34)
            
            // Error label
            Text("Please enter a valid phone number.")
                .foregroundColor(.red)
                .font(Font.smallText)
                .padding(.top, 20)
                .opacity(isErrorLabelVisible ? 1 : 0)
            
            Spacer()
            
            Button {
                // hide error message
                isErrorLabelVisible = false
                
                // disable the button
                isButtonDisabled = true
                
                // Send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationcode) { error in
                    
                    // Check for errors
                    if error == nil {
                        
                        DatabaseService().checkUserProfile { exists in
                            if exists {
                                isOnboarding = false
                                
                                contactsViewModel.getLocalContacts()
                                
                                chatViewModel.getChats()
                            }
                            else {
                                currentStep = .profile
                            }
                        }
                    }
                    else {
                        // Show error message
                        isErrorLabelVisible = true
                    }
                    
                    // Reenable the button
                    isButtonDisabled = false
                }
                
                
                
            } label: {
                
                HStack {
                    Text("Next")
                    
                    if isButtonDisabled {
                        ProgressView()
                            .padding(.leading, 2)
                    }
                }
                
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            .disabled(isButtonDisabled)
            
        }
        .padding(.horizontal)
        
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(currentStep: .constant(.verification), isOnboarding: .constant(true))
    }
}
