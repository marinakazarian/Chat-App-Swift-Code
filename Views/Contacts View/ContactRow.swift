//
//  ContactRow.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/6/24.
//

import SwiftUI

struct ContactRow: View {
    var user: User
    
    var body: some View {

        HStack (spacing: 24) {

            ProfilePicView(user: user)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(user.firstname ?? "") \(user.lastname ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                Text(user.phone ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            Spacer()
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(user: User())
    }
}
