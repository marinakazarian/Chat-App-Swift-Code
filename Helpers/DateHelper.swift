//
//  DateHelper.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/6/24.
//

import Foundation

class DateHelper {
    
    static func chatTimestampFrom(date: Date?) -> String {
        
        guard date != nil else {
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        
        return df.string(from: date!)
    }
    
}
