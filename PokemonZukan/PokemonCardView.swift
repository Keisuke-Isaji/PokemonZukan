//
//  PokemonCardView.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/23.
//

import SwiftUI

struct PokemonCardView: View {
    @State var pokemonName: String = "Loading..."
    let pokemon: Pokemon

    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemonId: pokemon.id ?? 0, name:pokemonName, url: pokemon.url)){
            HStack {
                AsyncImage(url: pokemon.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    Image(.migawari)
                        .resizable()
                        .padding()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                VStack {
                    HStack {
                        Text("No.\(pokemon.id?.description ?? "")")
                        Spacer()
                    }
                    HStack {
                        Text(pokemonName)
                            .redacted(reason: pokemonName != "Loading..." ? [] : .placeholder)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
            }
        }
        .onAppear() {
            PokeLoader().loadPokemonSpecies(id: pokemon.id ?? 0) { result in
                switch result {
                case .success(let pokemons):
                    print(pokemons)
                    self.pokemonName = pokemons.names.filter({(pokemon) in pokemon.language.name == "ja"}).first?.name ?? ""
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}


#Preview {
    PokemonCardView(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
