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

    // MARK: - Load user from local session
    func fetchUser() {
        if let savedUser = SessionManager.shared.getCurrentUser() {
            self.user = savedUser
        } else {
            self.errorMessage = "User not found."
        }
    }

    // MARK: - Logout
    // Clears user session
    func logout() {
        SessionManager.shared.logout()
        user = nil
        isLoggedOut = true
    }

    // MARK: - Update User Profile
    func updateUser(user: User?, confirmPassword: String?, completion: @escaping (Bool) -> Void) {
        // Check for valid user object
        guard let user = user else {
            errorMessage = "User data is missing."
            completion(false)
            return
        }

        // MARK: - Input Validation
        if let validationError = user.validate(confirmationPassword: confirmPassword) {
            errorMessage = validationError
            completion(false)
            return
        }

        isLoading = true
        errorMessage = nil

        // MARK: - Update Request
        // Sends update request and handles response
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
