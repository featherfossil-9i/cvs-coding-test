//
//  CharacterDetail.swift
//  RickAndMorty
//
//  Created by Thomas De Leon on 1/9/26.
//

import SwiftUI

struct CharacterDetail: View {
    let character: Character
    var body: some View {
        VStack {
            if let url = character.image {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .padding()
                }
            }
            
            GroupBox {
                LabeledContent("Species:", value: character.species)
                LabeledContent("Status:", value: character.status.rawValue)
                LabeledContent("Origin:") {
                    if let urlString = character.origin.url,
                       let url = URL(string: urlString) {
                        Link(character.origin.name, destination: url)
                    } else {
                        Text(character.origin.name)
                    }
                }
                if let type = character.type {
                    LabeledContent("Type:", value: type)
                }
                LabeledContent("Created:", value: character.created, format: .dateTime)
            }
            .padding()
        }
        .navigationTitle(character.name)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        CharacterDetail(character: .samples[0])
    }
}
#endif
