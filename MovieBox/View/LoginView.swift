//
//  LoginView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    @State private var showRegister = false
    @State private var isSecure = true
    @State private var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome Back")
                    .font(.largeTitle.weight(.semibold))
                    .padding(.top, 50)
                
                Spacer()
                
                VStack(spacing: 10) {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
                    
                    ZStack(alignment: .trailing) {
                        if isSecure {
                            SecureField("Password", text: $viewModel.password)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .padding(.horizontal, 15)
                                .padding(.trailing, 40)
                        } else {
                            TextField("Password", text: $viewModel.password)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .padding(.horizontal, 15)
                                .padding(.trailing, 40)
                        }
                        
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
                }
                .font(.body)
                .foregroundColor(.primary)
                
                Button(action: {
                    viewModel.login()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    } else {
                        Text("Login")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 30)

                Button(action: {
                    showRegister = true
                }) {
                    Text("Don't have an account? Register")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $showRegister) {
            RegisterView()
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Login Failed"),
                message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onReceive(viewModel.$errorMessage) { error in
            if error != nil {
                showErrorAlert = true
            }
        }
    }
}
