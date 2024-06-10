//
//  Chat.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/6/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var numparticipants: Int
    
    var participantids: [String]
    
    var lastmsg: String?
    
    @ServerTimestamp var updated: Date?
    
    var msgs: [ChatMessage]?
}

struct ChatMessage: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String?
    
    var imageurl: String?
    
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var senderid: String
}
