//
//  SessionManager.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation
import Combine

/// Manages the user session and authentication state using UserDefaults.
final class SessionManager: ObservableObject {
    
    static let shared = SessionManager()
    private init() {}
        
    @Published private(set) var isLoggedIn: Bool = false
    
    // MARK: - in response user and token we need to keep
    private enum Keys {
        static let authToken = "authToken"
        static let user = "user"
    }
    
    // MARK: - Session Lifecycle
    
    // Update login status.
    func loadUserSession() {
        isLoggedIn = getToken() != nil
    }
    
    // Clear User defaultss
    func logout() {
        UserDefaults.standard.removeObject(forKey: Keys.authToken)
        UserDefaults.standard.removeObject(forKey: Keys.user)
        isLoggedIn = false
    }
    
    // MARK: - Data Management
    
    // Save  authentication token
    func keepData(_ token: String, user : User) {
        
        UserDefaults.standard.set(token, forKey: Keys.authToken)
        saveUser(user)
        isLoggedIn = true
    }
    // save / update user
    func saveUser(_ user: User) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        UserDefaults.standard.set(data, forKey: Keys.user)
    }

    // Retrieves the saved authentication token.
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: Keys.authToken)
    }

    // Retrieves the current user from stored data.
    func getCurrentUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: Keys.user),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }
}
