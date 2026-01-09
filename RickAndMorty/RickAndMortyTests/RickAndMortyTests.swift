//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Thomas De Leon on 1/9/26.
//

import Testing
import Foundation
@testable import RickAndMorty

struct RickAndMortyTests {

    @MainActor
    @Test func testFetchCharacters() async throws {
        let expected = Character.samples
        
        let fetch = MockCharactersFetch(results: expected)
        try #require(try await fetch.characters(name: "") == expected)
        
    }
    
    @MainActor
    @Test func testFetchCharactersError() async throws {
        let error = URLError(.badServerResponse)
        let fetch = MockCharactersFetch(error: error)
        
        await #expect(throws: error) {
            try await fetch.characters(name: "")
        }
    }

}
