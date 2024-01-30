//
//  Constants.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//
import Foundation
struct Constants {
    
    struct Urls {
        // MARK: Source
        static func urlForGetPokemonList(limit : Int, page: Int) -> URL {
            let offset = (page - 1) * limit //
            let urlStr = urlDefaultValue() + "pokemon?limit=\(limit)&offset=\(offset)"
            return URL(string: urlStr)!
        }
        
        static func urlForGetPokemonDetail(pokemonId : String) -> URL {
            let urlStr = urlDefaultValue() + "pokemon/\(pokemonId)"
            return URL(string: urlStr)!
        }
        
        static func urlDefaultValue() -> String {
            return "https://pokeapi.co/api/v2/"
        }
        
    }
}
