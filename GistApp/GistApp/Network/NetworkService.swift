//
//  NetworkService.swift
//  GistApp
//
//  Created by nastasya on 28.09.2024.
//

import Foundation

final class NetworkService: INetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://api.github.com/gists"

    private init() {}

    func fetchGists(completion: @escaping (Result<[Gist], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let gists = try JSONDecoder().decode([Gist].self, from: data)
                completion(.success(gists))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchGist(for id: String, completion: @escaping (Result<Gist, Error>) -> Void) {
        guard let url = URL(string: baseURL + "/" + id) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let gist = try JSONDecoder().decode(Gist.self, from: data)
                completion(.success(gist))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
