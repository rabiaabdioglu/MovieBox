//
//  AuthResponse.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation

struct AuthResponse: Codable {
    let message: String
    let token: String
    let user: User
}

