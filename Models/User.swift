//
//  User.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/5/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String?
    
    var firstname: String?
    
    var lastname: String?
    
    var phone: String?
    
    var photo: String?
    
    var isactive: Bool = true

}
