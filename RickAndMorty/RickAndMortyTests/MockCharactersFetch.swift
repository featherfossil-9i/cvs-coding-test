//
//  MockCharactersFetch.swift
//  RickAndMortyTests
//
//  Created by Thomas De Leon on 1/9/26.
//

import Foundation
@testable import RickAndMorty

struct MockCharactersFetch: CharacterFetching {
    let url = URL(string: "https://example.com")!
    
    var results: [Character] = []
    var error: Error?
    
    static var fetchedURL: URL?
    
    func characters(from url: URL) async throws -> CharacterResponse {
        Self.fetchedURL = url
        if let error {
            throw error
        } else {
            return CharacterResponse(results: results)
        }
    }
}
