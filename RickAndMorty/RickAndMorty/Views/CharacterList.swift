//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Thomas De Leon on 1/9/26.
//

import SwiftUI

struct CharacterList: View {
    @State private var model = CharactersModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(model.characters) { character in
                        NavigationLink {
                            CharacterDetail(character: character)
                        } label: {
                            CharacterRow(character: character)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Characters")
            .overlay(content: contentUnavailable)
        }
        .searchable(text: $searchText, prompt: "Search for Characters")
        .task(id: searchText) {            
            await model.fetchCharacters(name: searchText)
        }
    }
    
    @ViewBuilder
    private func contentUnavailable() -> some View {
        if model.isFetching {
            ContentUnavailableView {
                VStack {
                    ProgressView()
                    Text("Searching...")
                }
            }
        } else if let errorMessage = model.errorMessage {
            ContentUnavailableView("Error", systemImage: "xmark.circle.fill", description: Text(errorMessage))
                .symbolRenderingMode(.multicolor)
        } else if model.characters.isEmpty {
            let description = searchText.isEmpty ? nil : Text("No results found for '\(searchText)'")
            ContentUnavailableView("Search Characters", systemImage: "magnifyingglass", description: description)
        }
    }
}

struct CharacterRow: View {
    let character: Character
    var body: some View {
        HStack(alignment: .top) {
            if let url = character.image {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 20))
                } placeholder: {
                    Image(.placeholder)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 20))
                }
            }

            VStack(alignment: .leading) {
                Text(character.name)
                    .multilineTextAlignment(.leading)
                    .font(.title2)
                Text(character.species)
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.gradient.opacity(0.7), in: .rect(cornerRadius: 20))
    }
}

#if DEBUG
#Preview {
    CharacterList()
}

#Preview {
    CharacterRow(character: .samples[0])
}
#endif
