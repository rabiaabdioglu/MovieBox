//
//  MovieCardView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//
import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                // Poster
                RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 250)
                        .overlay(
                            WebImage(url: URL(string: movie.posterURL))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 7))

                        )
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .frame(height: 250)

                
                // IMDb Score Badge
                Text(String(format: "%.1f", movie.rating))
                    .font(Fonts.Caption.semibold)
                    .foregroundColor(.secondaryText)
                    .frame(width: 30, height: 30)
                    .background(Color.rating)
                    .clipShape(Circle())
                    .shadow(radius: 2)
                    .padding(8)
            }
            
            Spacer()
            
            // Movie Name
            Text(movie.title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .bottom)
            
            Spacer()
            
            // Category and Year
            Text("\(movie.category) • \(Int(movie.year))")
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .frame(height: 320)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
        )
    }
}
