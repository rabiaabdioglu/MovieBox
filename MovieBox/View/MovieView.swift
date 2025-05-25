
//
//  MovieView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @State private var isLiked: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
    
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { geo in
                        let offset = geo.frame(in: .global).minY
                        
                        // Movie poster
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
                        // IMDb Rating with star aligned to top-trailing
                        HStack {
                            // Movie title
                            Text(movie.title)
                                .font(Fonts.Title.largeSemibold)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            //Imdb rank
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
                        

                        // Movie detail
                        Text("\(movie.year) • \(movie.category) ")
                            .font(Fonts.Subtitle.mediumSemibold)
                            .foregroundColor(.secondary)

                        // Actors
                        Text("Actors: \(movie.actors.joined(separator: ", "))")
                            .font(Fonts.Subtitle.regular)
                            .foregroundColor(.secondary)

                        // Description
                        Text(movie.description)
                            .font(Fonts.Content.regular)
                            .foregroundColor(.primary)
                            .padding(.top, 8)

                        // Favorite button
                        Button(action: {
                            isLiked.toggle()
                            print(isLiked ? "Liked: \(movie.title)" : "Unliked: \(movie.title)")
                        }) {
                            Label(
                                isLiked ? "Unlike Movie" : "Like Movie",
                                systemImage: isLiked ? "heart.slash.fill" : "heart.fill"
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isLiked ? .dangerButton : .infoButton)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(.top, 20)

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
                  }
              }
          }
        .toolbarBackground(.clear, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
  
    }
}

#Preview {
    MovieDetailView(movie: MockData.allMovies[0])
}
