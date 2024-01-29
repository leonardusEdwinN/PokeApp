//
//  ListPokemonResponse.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//
import Foundation
struct ListPokemonResponse : Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [ListPokemonResults]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        results = try values.decodeIfPresent([ListPokemonResults].self, forKey: .results)
    }

}
