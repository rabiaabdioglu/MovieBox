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
    let email: String?
    let password: String?

    // - use in the auth and update View Model
    func validate(for endpoint: AuthService.Endpoint? = nil, confirmationPassword: String? = nil) -> String? {
        if (name ?? "").isEmpty {
            return "Name cannot be empty."
        }
        
        if (surname ?? "").isEmpty {
            return "Surname cannot be empty."
        }
        
        if email?.trimmingCharacters(in: .whitespaces).isEmpty == true || !(email?.contains("@") ?? false) {
            return "Please enter a valid email address."
        }
        
        if let password = password {
            if password.count < 6 {
                return "Password must be at least 6 characters long."
            }
            if let confirm = confirmationPassword, confirm != password {
                return "Passwords do not match."
            }
        } else if endpoint == .register || endpoint == .login {
            return "Password cannot be empty."
        }

        return nil
    }
}
