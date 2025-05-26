//
//  SplashView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//
import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
     
            
            if isActive {
                // MARK: - Navigate to main content
                ContentView()
                    .font(.custom("CustomFontName", size: 16))
                
            } else {
                Color.main
                    .ignoresSafeArea()
                VStack {
                    Image("Splash")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300, maxHeight: 300)

                    Text("MovieBox")
                        .font(Fonts.Header.largeSemibold)
                    
                        .foregroundColor(.background)
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 3)
                        .padding(.top, 10)
                }
                .transition(.opacity)
                .onAppear {
                    // MARK: - Splash duration
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
