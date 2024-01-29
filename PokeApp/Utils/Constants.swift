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
        
        
        
        
        // MARK: ARTICLES
        static func urlForGetNewsFromSourceName(sourceKeyword: String, pageSize : Int, page: Int) -> URL {
//            print("https://newsapi.org/v2/top-headlines?sources=\(sourceKeyword.escaped())&apiKey=\(Constants.API_KEYS)&page=\(page)&pageSize=\(pageSize)")
            return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(sourceKeyword.escaped())&apiKey=\(Constants.API_KEYS)&page=\(page)&pageSize=\(pageSize)")!
        }
        
        static func urlForGetNewsFromKeyword(keyword: String, pageSize : Int, page: Int) -> URL {
            return URL(string: "https://newsapi.org/v2/top-headlines?apiKey=\(Constants.API_KEYS)&q=\(keyword.escaped())&pageSize=\(pageSize)&page=\(page)")!
        }
        
        static func urlDefaultValue() -> String {
            return "https://pokeapi.co/api/v2/"
        }
        
    }
//    6447817f8d9c44d2b93bed6580d3f848
//    c00b33fac0df44d0b8102227f3cebed6
//    5fc856f254354965a75b1e18a922007e
//    static let API_KEYS = "91ed7f8de793449fb6caffbdbb1ce0e4"
    static let API_KEYS = "6447817f8d9c44d2b93bed6580d3f848"
    
    
}
