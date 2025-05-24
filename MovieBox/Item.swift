//
//  Item.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
