//
//  HomeView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var movies: [Movie] = MockData.allMovies
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationView {
            
        //    EmptyResultView(imageName: "movie", message: "There is no movies")

            VStack(spacing: 0) {
               
                HStack {
                    Text("Movies")
                        .font(Fonts.Title.mediumRegular)
                        .foregroundColor(Color.primary)
                    
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundColor(Color.secondaryText)
                    
                    Image(systemName: "slider.horizontal.3") 
                        .font(.system(size: 20))
                        .foregroundColor(Color.secondaryText)
                        .padding(.leading, 8)
                    
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 20))
                        .foregroundColor(Color.secondaryText)
                        .padding(.leading, 8)
                }
                
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    Color(.background)
                        .shadow(color: .secondaryBackground.opacity(0.09), radius: 2, x: 0, y: 2)
                )
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCardView(movie: movie)
                                    .frame(height: 320)
                                
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            
        }
    }
}    

#Preview {
    HomeView()
}
