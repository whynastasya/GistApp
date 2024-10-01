//
//  Author.swift
//  GistApp
//
//  Created by nastasya on 26.09.2024.
//

struct Author: Decodable {
    var name: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}
