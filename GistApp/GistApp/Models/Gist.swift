//
//  Gist.swift
//  GistApp
//
//  Created by nastasya on 28.09.2024.
//

struct Gist: Decodable {
    var id: String
    var name: String
    var author: Author
    var filesNames: [String]
    var commits: [Commit]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case author = "owner"
        case filesNames = "files"
        case commits = "history"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(Author.self, forKey: .author)
        
        let files = try container.decode([String: File].self, forKey: .filesNames)
        filesNames = files.map { $0.value.filename }
        
        name = filesNames.first ?? "Unnamed Gist"
        
        commits = try? container.decode([Commit].self, forKey: .commits)
    }
}
