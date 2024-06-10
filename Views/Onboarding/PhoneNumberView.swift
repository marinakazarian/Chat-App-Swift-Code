//
//  PhoneNumberView.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/5/24.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    
    @State var phoneNumber = ""
    
    @State var isButtonDisabled = false
    
    @State var isErrorLabelVisible = false

    var body: some View {
        
        VStack {
            
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter your mobile number below. We’ll send you a verification code after.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("e.g. +1 613 515 0123", text: $phoneNumber)
                        .foregroundColor(Color("text-textfield"))
                        .font(Font.bodyParagraph)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextHelper.applyPatternOnNumbers(&phoneNumber,
                                                             pattern: "+# (###) ###-####",
                                                             replacementCharacter: "#")
                        }
                        .placeholder(when: phoneNumber.isEmpty) {
                            Text("e.g. +1 613 515 0123")
                                .foregroundColor(Color("text-textfield"))
                                .font(Font.bodyParagraph)
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        phoneNumber = ""
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
                // hide the error message
                isErrorLabelVisible = false
                
                // disable the button from multiple taps
                isButtonDisabled = true
                
                // Send their phone number to Firebase Auth
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    
                    // Check for errors
                    if error == nil {
                        
                        // Move to the next step
                        currentStep = .verification
                    }
                    else {
                        print(error!)
                        // show an error
                        isErrorLabelVisible = true
                    }
                    
                    // reenable button
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

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(currentStep: .constant(.phonenumber))
    }
}
