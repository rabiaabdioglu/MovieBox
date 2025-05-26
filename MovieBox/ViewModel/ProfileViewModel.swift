//
//  ProfileViewModel.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var updatedUser: User?
    @Published var isLoggedOut = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let userService = UserService()

    init() {
        fetchUser()
    }

    // Load user from local session
    func fetchUser() {
        if let savedUser = SessionManager.shared.getCurrentUser() {
            self.user = savedUser
        } else {
            self.errorMessage = "User not found."
        }
    }

    // Log the user out
    func logout() {
        SessionManager.shared.logout()
        user = nil
        isLoggedOut = true
    }

    // Update user profile with validation
    func updateUser(user: User?, confirmPassword: String?, completion: @escaping (Bool) -> Void) {
        print("Sending update with data: name=\(user!)")
        guard let user = user else {
            errorMessage = "User data is missing."
            completion(false)
            return
        }

        // Validate user input
        if let validationError = user.validate(confirmationPassword: confirmPassword) {
            errorMessage = validationError
            completion(false)
            return
        }

        isLoading = true
        errorMessage = nil

        // Send request to update profile
        userService.updateUser(user) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let updatedUser):
                    self?.user = updatedUser
                    SessionManager.shared.saveUser(updatedUser)
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}
