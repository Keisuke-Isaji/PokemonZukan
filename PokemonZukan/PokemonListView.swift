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
    @State var currentPageIndex = 0
    @State var pokemonList: [Pokemon] = []
    @State var filteredPokemonList: [Pokemon] = []

    func setFilteredPokemonList(index: Int) {
        self.filteredPokemonList = pokemonList.filter({ (pokemon) in pokemon.id ?? 0 >= (currentPageIndex * 100) + 1 && pokemon.id ?? 0 < (currentPageIndex + 1) * 100})
    }

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
                        .frame(width:20, height: 20)
                }
                Spacer()
            }
            NavigationStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.currentPageIndex -= 1
                        setFilteredPokemonList(index: self.currentPageIndex)
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .disabled(currentPageIndex < 1)
                    Spacer()
                    Text("No.\(filteredPokemonList.first?.id?.description ?? "nil")~No.\(filteredPokemonList.last?.id?.description ?? "nil")")
                    Text("/ \((self.currentPageIndex + 1).description)ページ目")
                    Spacer()
                    Button(action: {
                        self.currentPageIndex += 1
                        setFilteredPokemonList(index: self.currentPageIndex)
                    }) {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .disabled(filteredPokemonList.count < 99)
                    Spacer()
                }
                List(filteredPokemonList,id: \.name) { pokemon in
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
                        setFilteredPokemonList(index: self.currentPageIndex)

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
