//
//  PokemonDetailView.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/24.
//

import SwiftUI
import AVFoundation

struct PokemonDetailView: View {
    @State var pokemonDetail: PokemonDetail? = nil
    @State var isFavorite: Bool = false
    @State private var player: AVPlayer?
    @State var pokemonTypesJP: [String] = [""]
    @State var flavorText: String = "loading..."

    let pokemonId: Int
    let name: String
    let url: String

    var body: some View {
        VStack(spacing: 13) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                NavigationStack {
                    PokemonColorView(type: pokemonDetail?.types[0].type.name ?? "")}
                .opacity(0.5)
                .onAppear() {
                    let pokeLoader = PokeLoader()
                    pokeLoader.loadPokemon(url: url) { result in
                        switch result {
                        case .success(let pokemon):
                            print(pokemon)
                            self.pokemonDetail = pokemon
                        case .failure(let error):
                            print(error)
                        }
                    }
                    pokeLoader.loadPokemonSpecies(id: pokemonId) { result in
                        switch result {
                        case .success(let pokemons):
                            print(pokemons)
                            self.flavorText = pokemons.flavor_text_entries.filter({(pokemon) in pokemon.language.name == "ja"}).first?.flavor_text ?? pokemons.flavor_text_entries.filter({(pokemon) in pokemon.language.name == "en"}).first?.flavor_text ?? "loading..."
                        case .failure(let error):
                            print(error)
                        }
                    }
                    //                    let playerItem = AVPlayerItem(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/1.ogg")!)
                    //                    self.player = AVPlayer(playerItem: playerItem)
                }
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonId).png")){ image in
                    image.resizable()
                } placeholder: {
                    VStack {
                        Spacer()
                        Image(.monsterBall)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                }
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
            })
            HStack(alignment: .center) {
                Text(name.capitalized)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .redacted(reason: self.pokemonDetail == nil ? .placeholder : [])
                if (self.isFavorite) {
                    Button(action: {
                        self.isFavorite = false
                        print("isFavorite:\(isFavorite)")
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.yellow)
                    }
                } else {
                    Button(action: {
                        self.isFavorite = true
                        print("isFavorite:\(isFavorite)")
                    }) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.yellow)
                    }
                }
            }
            HStack(alignment: .top) {
                if (self.pokemonDetail != nil) {
                    ForEach(self.pokemonDetail?.types ?? [], id: \.id) { type in
                        ZStack {
                            Rectangle()
                                .frame(width: 100,height: 40)
                                .opacity(0.5)
                                .cornerRadius(10)
                                .foregroundStyle(PokemonColor(type: type.type.name).typeToColor())
                            Text("\(type.type.name)".capitalized)
                                .font(.headline)
                        }
                    }
                } else {
                    ZStack {
                        Rectangle()
                            .frame(width: 100,height: 40)
                            .opacity(0.5)
                            .cornerRadius(10)
                            .foregroundStyle(Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255))
                        Text("-----")
                            .font(.headline)
                            .redacted(reason: self.pokemonDetail == nil ? .placeholder : [])

                    }
                }
            }

            HStack {
                if (pokemonDetail != nil) {
                    Text(" 高さ:\(String(format: "%.1f",pokemonDetail!.height/10))m ")
                        .font(.title2)
                        .background(.gray.opacity(0.2))
                    Text(" 重さ:\(String(format: "%.1f",pokemonDetail!.weight/10))kg ")
                        .font(.title2)
                        .background(.gray.opacity(0.2))
                }
            }
            HStack {
                Spacer(minLength: 20)
                Text("\(self.flavorText)")
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .redacted(reason: self.flavorText == "loading..." ? .placeholder : [] )
                Spacer(minLength: 20)
            }
        }

        //        Spacer(minLength: 300)
    }
}



#Preview {
    PokemonDetailView(pokemonId: 1, name:"bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}
