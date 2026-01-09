//
//  CharacterFetching.swift
//  RickAndMorty
//
//  Created by Thomas De Leon on 1/9/26.
//

import Foundation

protocol CharacterFetching {
    /// The URL for fetching characters
    var url: URL { get }
    
    /// Fetch characters by name
    /// - Parameter name: Name to search
    /// - Returns: Characters matching the searched name
    func characters(name: String) async throws -> [Character]
    
    /// Fetch a character response for the given URL
    /// - Parameter url: URL to fetch from
    /// - Returns: A response object
    func characters(from url: URL) async throws -> CharacterResponse
}

extension CharacterFetching {
    func characters(name: String) async throws -> [Character] {
        // add query items to search by name
        var url = self.url
        if !name.isEmpty {
            url.append(queryItems: [URLQueryItem(name: "name", value: name)])
        }
        
        // fetch the results
        return try await characters(from: url).results
    }
    
    func characters(from url: URL) async throws -> CharacterResponse {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let urlResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        
        // check for non-success codes
        guard urlResponse.statusCode == 200 else {
            // if not found, don't show an error, just return an empty array
            if urlResponse.statusCode == 404 {
                return CharacterResponse(results: [])
            } else {
                throw URLError(.badServerResponse)
            }
        }
        
        // decode json
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(CharacterResponse.self, from: data)
    }
}
