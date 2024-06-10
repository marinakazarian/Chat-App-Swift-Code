//
//  CacheService.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/7/24.
//

import Foundation
import SwiftUI

class CacheService {
    private static var imageCache = [String : Image]()
    
    static func getImage(forKey: String) -> Image? {
        return imageCache[forKey]
    }
    
    static func setImage(image: Image, forKey: String) {
        imageCache[forKey] = image
    }
}
