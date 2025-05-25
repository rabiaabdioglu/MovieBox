//
//  RegisterView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(Fonts.Title.largeSemibold)
                .padding(.top,50)
            Spacer()
            
            
            //Name
            VStack(spacing: 10) {
                TextField("Full Name", text: $name)
                    .padding()
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .background(Color.background)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
                
                //email
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .background(Color.background)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
                
                //password
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.background)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.background)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 3)
            }
            .font(Fonts.Content.regular)
            .foregroundColor(Color.primaryText)

            Button(action: {
                
            }) {
                Text("Register")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.infoButton)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.top,30)
            
            NavigationLink("Already have an account? Login", destination: LoginView())
                .font(Fonts.Caption.regular)
                .foregroundColor(.main)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
        .navigationBarHidden(true)
    }
}


#Preview {
    RegisterView()
}
