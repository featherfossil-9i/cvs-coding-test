//
//  Character.swift
//  RickAndMorty
//
//  Created by Thomas De Leon on 1/9/26.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    enum Status: String, Codable, Hashable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    struct Origin: Codable, Hashable {
        let name: String
        let url: String?
    }
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String?
    let origin: Origin
    let image: String?
    let created: Date
    
    var shareableMetadata: String {
        """
        Status: \(status)
        Species: \(species)
        \(type != nil ? "Type: \(type!)" : "")
        Origin: \(origin.name)
        Created: \(created)
        """
    }
}

/// Response for the /character API
struct CharacterResponse: Codable, Hashable {
    let results: [Character]
}

#if DEBUG
extension Character {
    static var samples: [Character] {
        [
            .init(
                id: 1,
                name: "Rick Sanchez",
                status: .alive,
                species: "Human",
                type: nil,
                origin: Character.Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                created: (try? Date("2017-11-04T18:48:46.250Z", strategy: .iso8601))!
            )
        ]
    }
}
#endif
