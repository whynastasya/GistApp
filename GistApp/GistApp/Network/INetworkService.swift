//
//  INetworkService.swift
//  GistApp
//
//  Created by nastasya on 28.09.2024.
//

protocol INetworkService: AnyObject {
    func fetchGists(completion: @escaping (Result<[Gist], Error>) -> Void)
    func fetchGist(for id: String, completion: @escaping (Result<Gist, Error>) -> Void)
}
