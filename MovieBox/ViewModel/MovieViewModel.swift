//
//  MoviewViewModel.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 26.05.2025.
//

import Foundation
import Combine

final class MovieViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var movies: [Movie] = []
    @Published var favoriteMovies: [Movie] = []
    @Published var likedMovieIDs: Set<Int> = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let movieService = MovieService()
    
    // MARK: - Initialization
    init() {
        fetchLikedMovieIDs()
    }
    
    // MARK: - Fetch Movies
    func fetchMovies() {
        isLoading = true
        errorMessage = nil
        
        movieService.getAllMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Fetch Liked Movie IDs
    func fetchLikedMovieIDs() {
        movieService.getLikedMovieIDs { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ids):
                    self?.likedMovieIDs = Set(ids)
                case .failure:
                    self?.likedMovieIDs = []
                }
            }
        }
    }
    // MARK: - Fetch Liked Movies
    func fetchLikedMovies() {
        movieService.getLikedMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.favoriteMovies = movies // Sadece burası eklendi
                case .failure:
                    self?.favoriteMovies = [] // Hata durumunda favoriteMovies temizleniyor
                }
            }
        }
    }

    
    // MARK: - Like / Unlike Movie
    func likeMovie(_ movie: Movie) {
        movieService.likeMovie(id: movie.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let likedIDs = response.likedMovies {
                        self?.likedMovieIDs = Set(likedIDs)
                    } else {
                        self?.likedMovieIDs.insert(movie.id)
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func unlikeMovie(_ movie: Movie) {
        movieService.unlikeMovie(id: movie.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let likedIDs = response.likedMovies {
                        self?.likedMovieIDs = Set(likedIDs)
                    } else {
                        self?.likedMovieIDs.remove(movie.id)
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
