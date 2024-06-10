//
//  ConversationPhotoMessage.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/7/24.
//

import SwiftUI

struct ConversationPhotoMessage: View {
    var imageUrl: String
    var isFromUser: Bool
    var isActive: Bool = true
    
    var body: some View {
        if !isActive {
            ConversationTextMessage(msg: "Photo Deleted", isFromUser: isFromUser, name: nil, isActive: isActive)
        }
        else if let cachedImage = CacheService.getImage(forKey: imageUrl) {
            
            cachedImage
                .resizable()
                .scaledToFill()
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
            
        }
        else {
            // Photo Message
            let photoUrl = URL(string: imageUrl)
            
            AsyncImage(url: photoUrl) { phase in
                switch phase {
                    
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .background(isFromUser ? Color("bubble-primary") : Color("bubble-secondary"))
                        .cornerRadius(30, corners: isFromUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                        .onAppear {
                            CacheService.setImage(image: image, forKey: imageUrl)
                        }
                    
                case .failure:
                    
                    ConversationTextMessage(msg: "Couldn't load image", isFromUser: isFromUser)
                    
                }
                
            }
        }    }
}

struct ConversationPhotoMessage_Previews: PreviewProvider {
    static var previews: some View {
        ConversationPhotoMessage(imageUrl: "", isFromUser: true)
    }
}
