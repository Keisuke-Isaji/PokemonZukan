//
//  FavoriteData.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/06/10.
//

import SwiftData

@Model
class FavoriteData {
    var pokemonId: Int

    init(pokemonId: Int) {
        self.pokemonId = pokemonId
    }
}
