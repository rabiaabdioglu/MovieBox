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
    
    // MARK: - Register Function
    func register() {
        clearError()
        let user = User(id: nil, name: name, surname: surname, email: email, password: password)

        // Validate user input
        if let error = user.validate(confirmationPassword: confirmPassword) {
            self.errorMessage = error
            return
        }

        // Send register request
        authenticate(user, for: .register) { [weak self] in
            self?.isRegistered = true
        }
    }
    
    // MARK: - Login Function
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

    // MARK: - Authentication Request
    // Handles both login and registration requests
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
    
    // MARK: - Clear Errors
    private func clearError() {
        errorMessage = nil
    }
}
