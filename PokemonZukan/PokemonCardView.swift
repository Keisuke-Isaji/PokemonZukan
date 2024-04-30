//
//  PokemonCardView.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/23.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon

    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemonId: pokemon.id ?? 0, name:pokemon.name.capitalized, url: pokemon.url)){
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

                Text(pokemon.name.capitalized)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.medium)
            }
        }
    }
}


#Preview {
    PokemonCardView(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
