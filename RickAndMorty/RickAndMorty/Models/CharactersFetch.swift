//
//  CharactersFetch.swift
//  RickAndMorty
//
//  Created by Thomas De Leon on 1/9/26.
//

import Foundation

struct CharactersFetch: CharacterFetching {
    let url = URL(string: "https://rickandmortyapi.com/api/character")!
}
