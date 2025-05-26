//
//  MovieModel.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//

import Foundation

struct Movie: Identifiable ,Codable{
    let id: Int
    let title: String
    let year: Int
    let rating: Double
    let actors: [String]
    let category: String
    let posterURL: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, year, rating, actors, category, description
        case posterURL = "poster_url"
    }
}
