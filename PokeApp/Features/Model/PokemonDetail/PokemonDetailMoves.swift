//
//  PokemonDetailMoves.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//
import Foundation
struct PokemonDetailMoves : Codable {
    let move : PokemonDetailMove?

    enum CodingKeys: String, CodingKey {
        case move = "move"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        move = try values.decodeIfPresent(PokemonDetailMove.self, forKey: .move)
    }

}

struct PokemonDetailMove : Codable {
    let name : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
