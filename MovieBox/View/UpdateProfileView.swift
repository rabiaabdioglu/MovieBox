//
//  UpdateProfileView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 26.05.2025.
//

import Foundation
import SwiftUI

struct UpdateProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ProfileViewModel

    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        VStack(spacing: 20) {

            HStack {
                Text("Update Profile")
                    .font(Fonts.Subtitle.mediumSemibold)
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.secondaryText)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)

            Spacer()
            // Input fields
            VStack(spacing: 10) {
                Group {
                    TextField("Name", text: $name)
                    TextField("Surname", text: $surname)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                .padding()
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
            }
            .font(Fonts.Subtitle.regular)
            .foregroundColor(Color.primary)

            // Show error message if any
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal)
            }

            // MARK: - Update
            Button(action: {
                let updatedUser = User(
                    id: viewModel.user?.id,
                    name: name,
                    surname: surname,
                    email: email,
                    password: password.isEmpty ? nil : password
                )

                viewModel.updateUser(user: updatedUser, confirmPassword: confirmPassword) { success in
                    if success {
                        dismiss()
                    }
                }
            }) {
                Text(viewModel.isLoading ? "Saving..." : "Save")
                    .font(Fonts.Subtitle.mediumSemibold)
                    .foregroundColor(Color.secondaryBackground)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.infoButton)
                    .cornerRadius(10)
                    .disabled(viewModel.isLoading)
            }
            .padding(.horizontal)	

            Spacer()
        }
        .padding(20)
        .background(Color.background)
        .onAppear {
            // fill fields with current user data
            if let user = viewModel.user {
                name = user.name ?? ""
                surname = user.surname ?? ""
                email = user.email ?? ""
            }
        }
    }
}
