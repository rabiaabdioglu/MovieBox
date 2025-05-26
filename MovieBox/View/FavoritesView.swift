//
//  FavoritesView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 26.05.2025.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.favoriteMovies.isEmpty {
                    EmptyResultView(imageName: "film", message: "No movies available")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.favoriteMovies) { movie in
                                NavigationLink(destination: MovieDetailView(viewModel: viewModel, movie: movie,isLiked: viewModel.likedMovieIDs.contains(movie.id))) {
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
            
            .onAppear {
                viewModel.fetchLikedMovies()
                viewModel.fetchLikedMovieIDs()
            }
        }
    }
}
