//
//  PokemonDetailView.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @State var pokemonDetail: PokemonDetail? = nil

    let pokemonId: Int
    let name: String
    let url: String

    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                NavigationStack {
                    PokemonColorView(type: pokemonDetail?.types[0].type.name ?? "")}
                .position(x:200, y:150)
                .opacity(0.5)
                .onAppear() {
                    PokeLoader().loadPokemon(url: url) { result in
                        switch result {
                        case .success(let pokemon):
                            print(pokemon)
                            self.pokemonDetail = pokemon
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonId).png")){ image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "number")
                        .resizable()
                        .padding()
                }
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                //                .position(y:100)
            })
            Text(name.capitalized)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
        }
    }
}

#Preview {
    PokemonDetailView(pokemonId: 1, name:"bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}
