//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Thomas De Leon on 1/9/26.
//

import Foundation
import OSLog

@Observable
final class CharactersModel {
    /// Found characters
    private(set) var characters: [Character] = []
    /// If a fetch is in progress
    var isFetching = false
    /// An error message to display
    var errorMessage: String?
    
    
    private let client: CharacterFetching
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CharactersModel.self))
    
    init(client: any CharacterFetching = CharactersFetch()) {
        self.client = client
    }
    
    /// Fetch characters matching the given name
    /// - Parameter name: Name to search for
    func fetchCharacters(name: String) async {
        defer { isFetching = false }
        characters.removeAll()
        errorMessage = nil
        
        guard !Task.isCancelled, !name.isEmpty  else { return }
        
        logger.info("Searching characters with name '\(name)'")
        isFetching = true
        
        do {
            let fetched = try await client.characters(name: name)
            logger.info("Fetched \(fetched.count) characters")
            characters = fetched
        } catch {
            logger.error("Failed to fetch characters - \(error)")
            errorMessage = String(localized: "Could not fetch characters, please try again.")
        }
        
    }
}
