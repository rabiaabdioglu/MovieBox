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
    @Published var isLoggedOut = false
    @Published var errorMessage: String?

    func loadUser() {
        if let savedUser = SessionManager.shared.getCurrentUser() {
            self.user = savedUser
        } else {
            self.errorMessage = "Kullanıcı bulunamadı."
        }
    }

    // Çıkış işlemi
    func logout() {
        SessionManager.shared.logout()
        user = nil
        isLoggedOut = true
    }
}
