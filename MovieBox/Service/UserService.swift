//
//  UserService.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 26.05.2025.
//

import Foundation
import Combine

final class UserService {
    private let baseURL = "https://moviatask.cerasus.app/api/users"

    func updateUser(_ user: User, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/profile") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = SessionManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let jsonDict: [String: Any] = [
            "name": user.name ?? "",
            "surname": user.surname ?? "",
            "email": user.email ?? "",
            "password": user.password ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonDict, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknown))
                return
            }

            print("Status code:", httpResponse.statusCode)


            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError.unknown))
                return
            }

            do {
                let response = try JSONDecoder().decode(UpdateUserResponse.self, from: data)
                completion(.success(response.user))
            } catch {
                print("Decoding error:", error)
                completion(.failure(error))
            }

        }.resume()
    }
}
