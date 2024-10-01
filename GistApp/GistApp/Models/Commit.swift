//
//  Commit.swift
//  GistApp
//
//  Created by nastasya on 28.09.2024.
//

import Foundation

struct Commit: Decodable {
    var author: Author
    var dateTime: Date
    var changeStatus: ChangeStatus
    
    enum CodingKeys: String, CodingKey {
        case author = "user"
        case dateTime = "committed_at"
        case changeStatus = "change_status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decode(Author.self, forKey: .author)
        
        let dateString = try container.decode(String.self, forKey: .dateTime)
        let dateFormatter = ISO8601DateFormatter()
        dateTime = dateFormatter.date(from: dateString) ?? Date()
        
        changeStatus = try container.decode(ChangeStatus.self, forKey: .changeStatus)
    }
}
