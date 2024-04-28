//
//  PokemonColor.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/26.
//

import Foundation
import SwiftUI

struct PokemonColorView: View {
//    var id: Int
    var type: String

    var color: Color {
        switch type.lowercased() {
        case "grass":    return Color(red: 166 / 255, green: 193 / 255, blue: 50 / 255)
        case "poison":   return Color(red: 157 / 255, green: 121 / 255, blue: 199 / 255)
        case "fire":     return Color(red: 234 / 255, green: 166 / 255, blue: 106 / 255)
        case "flying":   return Color(red: 123 / 255, green: 165 / 255, blue: 237 / 255)
        case "water":    return Color(red: 136 / 255, green: 197 / 255, blue: 245 / 255)
        case "bug":      return Color(red: 131 / 255, green: 203 / 255, blue: 98 / 255)
        case "normal":   return Color(red: 173 / 255, green: 173 / 255, blue: 173 / 255)
        case "electric": return Color(red: 226 / 255, green: 211 / 255, blue: 51 / 255)
        case "ground":   return Color(red: 191 / 255, green: 167 / 255, blue: 75 / 255)
        case "fairy":    return Color(red: 224 / 255, green: 118 / 255, blue: 152 / 255)
        case "rock":     return Color(red: 237 / 255, green: 198 / 255, blue: 61 / 255)
        case "steel":    return Color(red: 130 / 255, green: 137 / 255, blue: 163 / 255)
        case "ghost":    return Color(red: 115 / 255, green: 110 / 255, blue: 176 / 255)
        case "dark":     return Color(red: 111 / 255, green: 129 / 255, blue: 209 / 255)
        case "psychic":  return Color(red: 211 / 255, green: 128 / 255, blue: 240 / 255)
        case "dragon":   return Color(red: 228 / 255, green: 134 / 255, blue: 91 / 255)
        case "fighting": return Color(red: 210 / 255, green: 105 / 255, blue: 106 / 255)
        case "ice":      return Color(red: 151 / 255, green: 231 / 255, blue: 244 / 255)
        case "":      return Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)

        default: do {return Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)}
        }
    }

    var body: some View {
        Circle()
            .frame(height: 300)
            .foregroundStyle(self.color)
    }
}

#Preview {
    PokemonColorView(type: "")
}
