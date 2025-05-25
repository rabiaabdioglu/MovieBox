//
//  LoginView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Welcome Back")
                .font(Fonts.Title.largeSemibold)
                .padding(.top,50)
            
            Spacer()
            
            VStack(spacing: 10) {
                //email
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.background)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)

                // Secure password field
                ZStack(alignment: .trailing) {
                    if isSecure {
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .padding(.trailing, 40)
                    } else {
                        TextField("Password", text: $password)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .padding(.trailing, 40)
                    }
                    
                    // Show hide pass
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.background)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)

                
            }
            .font(Fonts.Content.regular)
            .foregroundColor(Color.primaryText)

            // Login Button
            Button(action: {

            }) {
                Text("Login")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.infoButton)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.top,30)

            NavigationLink("Don't have an account? Register", destination: RegisterView())
                .font(Fonts.Caption.semibold)
                .foregroundColor(.main)

            Spacer()
        }
        .padding()
        .navigationTitle("Login")
        .navigationBarHidden(true)
    }
}


#Preview {
    LoginView()
}
