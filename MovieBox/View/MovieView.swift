
//
//  MovieView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieViewModel
    let movie: Movie
    
    @Environment(\.presentationMode) var presentationMode
    // State to track if the movie is liked by the user
    var isLiked: Bool = false
    
    // MARK: - UI
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { geo in
                        let offset = geo.frame(in: .global).minY
                        
                        WebImage(url: URL(string: movie.posterURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: max(geometry.size.height * 0.9 - offset, 0))
                            .clipped()
                            .opacity(offset < 0 ? Double(1 + offset / 200) : 1)
                    }
                    .frame(height: geometry.size.height * 0.9)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text(movie.title)
                                .font(Fonts.Title.largeSemibold)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.rating)
                                    .font(.headline)
                                Text("\(String(format: "%.1f", movie.rating)) / 10")
                                    .font(Fonts.Caption.semibold)
                                    .foregroundColor(Color.secondaryText)
                            }
                            .padding(.trailing,10)
                        }
                        
                        Text("\(movie.year) • \(movie.category) ")
                            .font(Fonts.Subtitle.mediumSemibold)
                            .foregroundColor(.secondary)
                        
                        Text("Actors: \(movie.actors.joined(separator: ", "))")
                            .font(Fonts.Subtitle.regular)
                            .foregroundColor(.secondary)
                        
                        Text(movie.description)
                            .font(Fonts.Content.regular)
                            .foregroundColor(.primary)
                            .padding(.top, 8)
                        
                        // MARK: - Like- Unlike
                        
                        Button(action: {
                            if isLiked {
                                viewModel.unlikeMovie(movie)
                            } else {
                                
                                viewModel.likeMovie(movie)
                            }
                        }) {
                            
                            if viewModel.isLoading {
                                // Show loading
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(isLiked ? Color.dangerButton : Color.infoButton)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Label(
                                    isLiked ? "Unlike Movie" : "Like Movie",
                                    systemImage: isLiked ? "heart.slash.fill" : "heart.fill"
                                )
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isLiked ? Color.dangerButton : Color.infoButton)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(.top, 20)
                        .disabled(viewModel.isLoading) // Disable button
                        
                    }
                    .padding()
                    .padding(.top,10)
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                }
            }
            .background(Color.background)
            .edgesIgnoringSafeArea(.top)
            
        }
        
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.background)
                        .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 3)
                }
            }
        }
        // Make navigation bar transparent and hidden background
        .toolbarBackground(.clear, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        
    }
}
