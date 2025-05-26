//
//  MovieService.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 26.05.2025.
//

import Foundation

final class MovieService {
    private let baseURL = "https://moviatask.cerasus.app/api/"
    
    // MARK: - Prepare URLRequest with token if available
    private func makeRequest(url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Add Authorization header if token exists
        if let token = SessionManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    // MARK: - Fetch all movies
    func getAllMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)movies") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let request = makeRequest(url: url, method: "GET")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknown))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Like a movie
    func likeMovie(id: Int, completion: @escaping (Result<LikeUnlikeResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)movies/like/\(id)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let request = makeRequest(url: url, method: "POST")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            do {
                let response = try JSONDecoder().decode(LikeUnlikeResponse.self, from: data)
       //         print("like",response)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Unlike a movie
    func unlikeMovie(id: Int, completion: @escaping (Result<LikeUnlikeResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)movies/unlike/\(id)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let request = makeRequest(url: url, method: "POST")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            do {
                let response = try JSONDecoder().decode(LikeUnlikeResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Get liked movies
    func getLikedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)users/liked-movies") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let request = makeRequest(url: url, method: "GET")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Get liked movie IDs
   
    func getLikedMovieIDs(completion: @escaping (Result<[Int], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)users/liked-movie-ids") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = SessionManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unknown))
                return
            }
            
            do {
                let likedIDs = try JSONDecoder().decode([Int].self, from: data)
                completion(.success(likedIDs))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
