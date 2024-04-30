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
                    let playerItem = AVPlayerItem(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/1.ogg")!)
                    self.player = AVPlayer(playerItem: playerItem)
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
            Text(name.capitalized)
                .fontWeight(.bold)
                .font(.largeTitle)
                .redacted(reason: self.pokemonDetail == nil ? .placeholder : [])
            HStack {
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
        }
        if (self.isFavorite) {
            Button("お気に入り解除") {
                self.isFavorite = false
                print("isFavorite:\(isFavorite)")
            }
        } else {
            Button("お気に入りに追加") {
                guard let player = self.player else { return }
                player.play()
                self.isFavorite = true
                print("isFavorite:\(isFavorite)")
            }
        }
        Text(isFavorite.description)

        Spacer(minLength: 300)
    }
}


#Preview {
    PokemonDetailView(pokemonId: 1, name:"bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}
