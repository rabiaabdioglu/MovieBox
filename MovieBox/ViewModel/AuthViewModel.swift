//
//  AuthViewModel.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    
    // MARK: - Input Fields
    @Published var name = ""
    @Published var surname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    // MARK: - UI State
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isRegistered = false
    @Published var isLoggedIn = false

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Register
    func register() {
        clearError()
        
        guard validateRegistration() else { return }
        
        let user = User(id: nil, name: name, surname: surname, email: email, password: password)
        authenticate(user, for: .register) { [weak self] in
            self?.isRegistered = true
        }
    }
    
    // MARK: - Login
    func login() {
        clearError()
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password cannot be empty."
            return
        }
        
        let user = User(id: nil, name: nil, surname: nil, email: email, password: password)
        authenticate(user, for: .login) { [weak self] in
            self?.isLoggedIn = true
        }
    }

    // MARK: - Validation
    private func validateRegistration() -> Bool {
        guard !email.isEmpty, !name.isEmpty, !surname.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required."
            return false
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return false
        }
        if password.count < 6 {
               errorMessage = "Password is too short."
               return false
           }

        
        return true
    }
    
    // MARK: - Shared Auth Handler
    private func authenticate(_ user: User, for endpoint: AuthService.Endpoint, onSuccess: @escaping () -> Void) {
        isLoading = true
        
        AuthService.shared.authenticate(user, for: endpoint)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { _ in
                onSuccess()
            }
            .store(in: &cancellables)
    }
    
    private func clearError() {
        errorMessage = nil
    }
}
