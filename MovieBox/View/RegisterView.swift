//
//  RegisterView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var showErrorAlert = false
    @State private var showSuccessAlert = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: - Title
            Text("Create Account")
                .font(.largeTitle.weight(.semibold))
                .padding(.top, 50)
            
            Spacer()
            
            // MARK: - Input Fields
            VStack(spacing: 10) {
                Group {
                    TextField("Name", text: $viewModel.name)
                    TextField("Surname", text: $viewModel.surname)
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                        .textContentType(.newPassword)
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .textContentType(.newPassword)
                }
                .padding()
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
            }
            .font(.body)
            .foregroundColor(.primary)
            
            // MARK: - Register Button
            Button(action: {
                viewModel.register()
            }) {
                if viewModel.isLoading {
                    // Show loading spinner during registration
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                } else {
                    // Show Register button
                    Text("Register")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.top, 30)
            
            // MARK: - Navigate to Login
            Button("Already have an account? Login") {
                dismiss()
            }
            .font(.caption)
            .foregroundColor(.blue)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
        .navigationBarHidden(true)
        
        // MARK: - Error Alert
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Something went wrong."),
                dismissButton: .default(Text("OK"))
            )
        }
        
        // MARK: - Success Alert
        .alert("Success", isPresented: $showSuccessAlert, actions: {
            Button("OK") {
                dismiss()
            }
        }, message: {
            Text("Registration completed successfully.")
        })
        
        // MARK: - Handle Error and Success Updates
        .onReceive(viewModel.$errorMessage) { error in
            showErrorAlert = error != nil
        }
        .onReceive(viewModel.$isRegistered) { registered in
            if registered { showSuccessAlert = true }
        }
    }
}
