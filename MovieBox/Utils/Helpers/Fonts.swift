//
//  Fonts.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation
import SwiftUI

struct Fonts {
    struct Header {
        static let largeSemibold = Font.custom("Inter-SemiBold", size: 25)
    }
    
    struct Title {
        static let largeSemibold = Font.custom("Inter-SemiBold", size: 22)
        static let mediumSemibold = Font.custom("Inter-SemiBold", size: 18)
        static let mediumRegular = Font.custom("Inter-Regular", size: 18)
    }
    
    struct Subtitle {
        static let mediumSemibold = Font.custom("Inter-SemiBold", size: 16)
        static let regular = Font.custom("Inter-Regular", size: 15)
    }
    
    struct Content {
        static let regular = Font.custom("Inter-Regular", size: 14)
        static let semibold = Font.custom("Inter-SemiBold", size: 14)
        static let light = Font.custom("Inter-Light", size: 14)
    }
    
    struct Caption {
        static let semibold = Font.custom("Inter-SemiBold", size: 12)
        static let regular = Font.custom("Inter-Regular", size: 12)
        static let light = Font.custom("Inter-Light", size: 12)
    }
    
}
