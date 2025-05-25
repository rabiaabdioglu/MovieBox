//
//  NetworkError.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 25.05.2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case noInternet
    case timeout
    case serverError(status: Int)
    case invalidURL
    case invalidResponse
    case decodingError
    case unknown
    case encodingError

    var userMessage: String {
        switch self {
        case .noInternet:
            return "You're offline. Please check your connection."
        case .timeout:
            return "The request timed out. Please try again."
        case .serverError(let status):
            return "Server returned an error (Status: \(status))."
        case .invalidURL:
            return "Invalid request URL."
        case .invalidResponse:
            return "Unexpected server response."
        case .decodingError:
            return "Failed to decode the response."
        case .unknown:
            return "Something went wrong. Please try again."
        case .encodingError:
            return "Failed to encode user data. Please try again."

        }
    }

    var errorDescription: String? {
        return userMessage
    }
}
