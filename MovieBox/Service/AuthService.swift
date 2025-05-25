//
//  AuthService.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation
import Combine

final class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    private let baseURL = "https://moviatask.cerasus.app/api/auth"
    
    // MARK: - Endpoints
    enum Endpoint: String {
        case register = "/register"
        case login = "/login"
    }
    
    // MARK: - Public Interface
    
    /// Login and Register function- same response , different params
    func authenticate(_ user: User, for endpoint: Endpoint) -> AnyPublisher<AuthResponse, NetworkError> {
        switch createRequest(endpoint: endpoint, body: user) {
        case .success(let request):
            return performRequest(request)
                .handleEvents(receiveOutput: { response in
                    SessionManager.shared.keepData(response.token, user: response.user)
                })
                .eraseToAnyPublisher()
                
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    // MARK: - Helpers
    
    private func createRequest<T: Encodable>(endpoint: Endpoint, body: T) -> Result<URLRequest, NetworkError> {
        guard let url = URL(string: baseURL + endpoint.rawValue) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            print("Request JSON:", String(data: jsonData, encoding: .utf8) ?? "")
            request.httpBody = jsonData
            return .success(request)
        } catch {
            return .failure(.encodingError)
        }
    }
    
    private func performRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard (200..<300).contains(response.statusCode) else {
                    throw NetworkError.serverError(status: response.statusCode)
                }
                
                return try JSONDecoder().decode(T.self, from: output.data)
            }
            .mapError { error in
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet: return .noInternet
                    case .timedOut: return .timeout
                    default: return .unknown
                    }
                }
                return error as? NetworkError ?? .unknown
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
