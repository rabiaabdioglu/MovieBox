//
//  LikeUnlikeResponse.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 26.05.2025.
//


struct LikeUnlikeResponse: Codable {
    let message: String
    let likedMovies: [Int]?
}
