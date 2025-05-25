//
//  ProfileView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//
import SwiftUI

struct ProfileView: View {
    // User data based on JSON
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                        HStack {
                        Text("Profile")
                                .font(Fonts.Title.largeSemibold)
                            .foregroundColor(Color.primary)
                        Spacer()
   
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        Color(.background)
                            .shadow(color: .secondaryBackground.opacity(0.09), radius: 2, x: 0, y: 2)
                    )
              
                    VStack(spacing: 30) {
                        // Profile Image
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(Color.gray)
                            .clipShape(Circle())
                            .padding(.top, 30)
                        
                        // Name 
                        Text("\(viewModel.user?.name ?? "") \(viewModel.user?.surname ?? "")")
                            .font(Fonts.Title.largeSemibold)
                            .foregroundColor(Color.primary)
                        // Email
                        Text("\(viewModel.user?.email)")
                            .font(Fonts.Subtitle.regular)
                            .foregroundColor(Color.primary)
                        
                        Spacer()

                        // Update User Button
                            Button(action: {
                                print("Update User tapped")

                            }) {
                                HStack {
                                    Text("Update User")
                                        .font(Fonts.Subtitle.mediumSemibold)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(.infoButton)
                                .cornerRadius(10)
                            }
                            .padding(.horizontal,50)

                            // Logout Button
                            Button(action: {
                                viewModel.logout()

                            }) {
                                HStack {
                                    Text("Logout")
                                        .font(Fonts.Subtitle.mediumSemibold)
                                        .foregroundColor(.white)
                                    Image(systemName:  "power")
                                        .renderingMode(.template)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(.dangerButton)
                                .cornerRadius(10)
                                
                            }
                            .padding(.horizontal,50)
                            
                    }
                    .padding(.bottom,50)
                
            }
            .navigationBarTitleDisplayMode(.inline)
       
        }
    }
}


#Preview {
    ProfileView()
}
