//
//  PokeLoader.swift
//  PokemonZukan
//
//  Created by 伊佐治恵介 on 2024/04/22.
//

import Alamofire

class PokeLoader {
    func loadPokemonList (completion: @escaping (Result<[Pokemon], Error>) -> ()) {
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=2000").responseDecodable(of: PokemonList.self) { response in

            switch response.result {
            case .success(let pokemonList):
                completion(.success(pokemonList.results))
            case .failure(let error):
                completion(.failure(error))
            }
            print(response.result)
        }
    }

    func loadPokemon (url: String,completion: @escaping (Result<PokemonDetail, Error>) -> ()) {
        AF.request(url).responseDecodable(of: PokemonDetail.self) { response in

            switch response.result {
            case .success(let pokemonDetail):
                completion(.success(pokemonDetail))
            case .failure(let error):
                completion(.failure(error))
            }
            print(response.result)
        }
    }

    func loadPokemonSpecies (id: Int,completion: @escaping (Result<PokemonSpecies, Error>) -> ()) {
        AF.request("https://pokeapi.co/api/v2/pokemon-species/\(id.description)/").responseDecodable(of: PokemonSpecies.self) { response in

            switch response.result {
            case .success(let pokemonSpecies):
                completion(.success(pokemonSpecies.self))
            case .failure(let error):
                completion(.failure(error))
            }
            print(response.result)
        }
    }

    func loadPokemonTypeJP (url: String,completion: @escaping (Result<[PropDetails], Error>) -> ()) {
        AF.request(url).responseDecodable(of: PokemonTypeResponse.self) { response in

            switch response.result {
            case .success(let responses):
                completion(.success(responses.names))
            case .failure(let error):
                completion(.failure(error))
            }
            print(response.result)
        }
    }

//    func postFavoritePokemon(id: Int) {
//        AF.request("")
//    }
}
