//
//  CharacterDetail.swift
//  RickAndMorty
//
//  Created by Thomas De Leon on 1/9/26.
//

import SwiftUI

struct CharacterDetail: View {
    let character: Character
    
    @State private var shareableImage: Image?
    
    var body: some View {
        VStack {
            if let url = character.image {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            shareableImage = image
                        }
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if let image = shareableImage {
                    ShareLink(
                        item: image,
                        subject: Text(character.name),
                        message: Text(character.shareableMetadata),
                        preview: SharePreview(character.name, image: image)
                    )
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        CharacterDetail(character: .samples[0])
    }
}
#endif
