//
//  PokemonDetailView.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonId: Int

    var body: some View {
        Text(pokemonId.description)
    }
}

#Preview {
    PokemonDetailView(pokemonId: 1)
}
