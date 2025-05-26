//
//  MovieService.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 26.05.2025.
//

import Foundation

final class MovieService {
    private let baseURL = "https://moviatask.cerasus.app/api/movies"
    
    func getAllMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
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
}
