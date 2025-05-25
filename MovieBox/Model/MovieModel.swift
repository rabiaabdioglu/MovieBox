//
//  MovieModel.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import Foundation

struct Movie: Identifiable {
    let id: Int
    let title: String
    let year: Int
    let rating: Double
    let actors: [String]
    let category: String
    let posterURL: String
    let description: String
}

struct MockData {
    static let allMovies: [Movie] = [
        Movie(
            id: 1,
            title: "Inception",
            year: 2010,
            rating: 8.8,
            actors: ["Leonardo DiCaprio", "Joseph Gordon-Levitt", "Elliot Page"],
            category: "Science Fiction",
            posterURL: "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_FMjpg_UX1000_.jpg",
            description: "A skilled thief is offered a chance to erase his criminal history by planting an idea into a target's subconscious."
        )    ]
}
