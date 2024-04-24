//
//  PokeLoader.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/22.
//

import Alamofire

class PokeLoader {
    func loadPokemon (completion: @escaping (Result<[Pokemon], Error>) -> ()) {
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=251").responseDecodable(of: PokemonList.self) { response in

            switch response.result {
            case .success(let pokemonList):
                completion(.success(pokemonList.results))
            case .failure(let error):
                completion(.failure(error))
            }

        }
    }
}
