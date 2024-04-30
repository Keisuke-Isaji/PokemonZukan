//
//  Pokemon.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/23.
//

import Foundation
import Alamofire

struct PokemonList: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String

    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }

    var imageURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png")
    }
}

struct PokemonDetail: Decodable,Identifiable {
    let id: Int
    var types: [PokemonType]

    var imageURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}

struct PokemonType: Decodable {
    var id: Int {slot}
    let slot: Int
    let type: TypeDetails
}

struct TypeDetails: Decodable {
    let name: String
    let url: String
}
