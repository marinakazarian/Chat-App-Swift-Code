//
//  ProfilePicView.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/6/24.
//

import SwiftUI

struct ProfilePicView: View {
    var user: User
    
    var body: some View {
        
        ZStack {
            
            if user.photo == nil {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text(user.firstname?.prefix(1) ?? "")
                        .bold()
                        .foregroundColor(Color("text-secondary"))
                }
            }
            else {
                if let cachedImage = CacheService.getImage(forKey: user.photo!) {
                    
                    cachedImage
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .clipped()
                    
                }
                else {
                    let photoUrl = URL(string: user.photo ?? "")

                    AsyncImage(url: photoUrl) { phase in
                        switch phase {
                            
                        case .empty:
                            ProgressView()
                            
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .clipped()
                                .onAppear {
                                    CacheService.setImage(image: image, forKey: user.photo!)
                                }
                            
                        case .failure(let error):
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                Text(user.firstname?.prefix(1) ?? "")
                                    .bold()
                                    .foregroundColor(Color("text-secondary"))
                            }
                        }
                        
                    }
                }
                
            }
            
            Circle()
                .stroke(Color("create-profile-border"), lineWidth: 2)
        }
        .frame(width: 44, height: 44)
    }
}

struct ProfilePicView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicView(user: User())
    }
}
