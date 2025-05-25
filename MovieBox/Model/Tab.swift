//
//  Tab.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "Home"
    case favorite = "Favorites"
    case profile = "Profile"


    var icon: String {
        switch self {
        case .home: return "movie"
        case .favorite: return "heart"
        case .profile: return "user"
        }
    }
    var index : Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
