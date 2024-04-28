//
//  ContentView.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/22.
//

import SwiftUI

struct PokemonListView: View {
    @State var pokemonList: [Pokemon] = []

    var body: some View {
        VStack {
//            HStack {
//                Image(.pokemonLogo)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                Text("図鑑(仮)")
//                    .fontWeight(.bold)
//                    .font(.largeTitle)
//            }
            NavigationStack {
                List(pokemonList,id: \.name) { pokemon in
                    PokemonCardView(pokemon: pokemon)
                }
            }
            .onAppear() {
                PokeLoader().loadPokemonList { result in
                    switch result {
                    case .success(let pokemonList):
                        self.pokemonList = pokemonList

                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonListView()
}
