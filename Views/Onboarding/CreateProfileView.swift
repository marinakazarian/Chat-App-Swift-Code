//
//  CreateProfileView.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/5/24.
//

import SwiftUI

struct CreateProfileView: View {
    @Binding var currentStep: OnboardingStep
    
    @State var firstName = ""
    @State var lastName = ""
    
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    
    @State var isSourceMenuShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    @State var isSaveButtonDisabled = false
    @State var isErrorLabelVisible = false

    @State var errorMessage = ""
    
    var body: some View {

        VStack {
            
            Text("Setup your Profile")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            Button {
                isSourceMenuShowing = true
            } label: {
                ZStack {
                    if selectedImage != nil {
                      Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }
                    else {
                        Circle()
                            .foregroundColor(.white)
                        
                        Circle()
                            .stroke(Color("create-profile-border"), lineWidth: 2)
                        
                        Image(systemName: "camera.fill")
                            .tint(Color("icons-input"))
                    }
                }
                .frame(width: 134, height: 134)
            }
            
            Spacer()
            
            TextField("Given name", text: $firstName)
                .textFieldStyle(CreateProfileTextFieldStyle())
                .placeholder(when: firstName.isEmpty) {
                    Text("Given name")
                        .foregroundColor(Color("text-textfield"))
                        .font(Font.bodyParagraph)
                }
            
            TextField("Last name", text: $lastName)
                .textFieldStyle(CreateProfileTextFieldStyle())
                .placeholder(when: lastName.isEmpty) {
                    Text("Last name")
                        .foregroundColor(Color("text-textfield"))
                        .font(Font.bodyParagraph)
                }
            
            // Error label
            Text(errorMessage)
                .foregroundColor(.red)
                .font(Font.smallText)
                .padding(.top, 20)
                .opacity(isErrorLabelVisible ? 1 : 0)
            
            Spacer()
            
            Button {
                
                isErrorLabelVisible = false
                
                // check that first and last names are filled out
                guard !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    
                    errorMessage = "Please enter in a valid first and last name."
                    isErrorLabelVisible = true
                    return
                    
                }
                
                isSaveButtonDisabled = true
                
                DatabaseService().setUserProfile(firstName: firstName, lastName: lastName, image: selectedImage) { isSuccess in
                    
                    if isSuccess {
                        currentStep = .contacts
                    }
                    else {
                        errorMessage = "Error occurred. Please try again."
                        isErrorLabelVisible = true
                    }
                    isSaveButtonDisabled = false
                }
                
//                currentStep = .contacts
            } label: {
                Text(isSaveButtonDisabled ? "Uploading" : "Save")
            }
            .buttonStyle(OnboardingButtonStyle())
            .disabled(isSaveButtonDisabled)
            .padding(.bottom, 87)
            
        }
        .padding(.horizontal)
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                self.source = .photoLibrary
                isPickerShowing = true
                
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button {
                    self.source = .camera
                    isPickerShowing = true
                    
                } label: {
                    Text("Take Photo")
                }
            }
            
        })
        .sheet(isPresented: $isPickerShowing) {
            
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: self.source)
            
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(currentStep: .constant(.contacts))
    }
}
