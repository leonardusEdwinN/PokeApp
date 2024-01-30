//
//  PokemonDetailResponse.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//

import Foundation
struct PokemonDetailResponse : Codable {
    let name : String?
    let sprites : PokemonDetailSprites?
    let types : [PokemonDetailTypes]?
    let weight : Int?
    let height: Int?
    let moves: [PokemonDetailMoves]?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case sprites = "sprites"
        case types = "types"
        case weight = "weight"
        case height = "height"
        case moves = "moves"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        sprites = try values.decodeIfPresent(PokemonDetailSprites.self, forKey: .sprites)
        types = try values.decodeIfPresent([PokemonDetailTypes].self, forKey: .types)
        weight = try values.decodeIfPresent(Int.self, forKey: .weight)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        moves = try values.decodeIfPresent([PokemonDetailMoves].self, forKey: .moves)
    }

}
