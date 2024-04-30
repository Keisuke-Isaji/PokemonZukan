//
//  ContentView.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/22.
//

import SwiftUI

struct PokemonListView: View {
    @State var isShowFavoriteList = false
    @State var currentTime = ""
    @State var pokemonList: [Pokemon] = []

    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 110)
                Text("\(currentTime)")
                    .font(.headline)
                Spacer()
                Button(action: {
                    self.isShowFavoriteList = !isShowFavoriteList
                }) {
                    Image(systemName: "text.badge.star")
                        .resizable()
                        .frame(width:20,height: 20)
                }
                Spacer()
                //                Image(.pokemonLogo)
                //                    .resizable()
                //                    .aspectRatio(contentMode: .fit)
            }
            NavigationStack {
                List(pokemonList,id: \.name) { pokemon in
                    PokemonCardView(pokemon: pokemon)
                }
            }
            .onAppear() {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                    currentTime = dateFormatter.string(from: Date())
                }
                PokeLoader().loadPokemonList { result in
                    switch result {
                    case .success(let pokemonList):
                        self.pokemonList = pokemonList

                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } .sheet(isPresented: $isShowFavoriteList, content: {
            FavoriteListView()
        })
    }
}

struct FavoriteListView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle")
            }
        }
        Spacer()
    }
}

#Preview {
    PokemonListView()
}
