//
//  PokemonDetailSprites.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//

import Foundation
struct PokemonDetailSprites : Codable {
    let frontDefault : String?
    let backDefault : String?

    enum CodingKeys: String, CodingKey {

        case frontDefault = "front_default"
        case backDefault = "back_default"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try values.decodeIfPresent(String.self, forKey: .frontDefault)
        backDefault = try values.decodeIfPresent(String.self, forKey: .backDefault)
    }

}
