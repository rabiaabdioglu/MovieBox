//
//  UserModel.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import Foundation

struct User: Codable {
    let id: String?
    let name: String?
    let surname: String?
    let email: String
    let password: String?
}
