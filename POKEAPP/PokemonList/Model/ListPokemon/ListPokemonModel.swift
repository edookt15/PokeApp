//
//  ListPokemonModel.swift
//  POKEAPP
//
//  Created by Phincon on 21/08/21.
//

import Foundation

struct ListPokemonModel : Codable {
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
}

struct ListPokemonResults : Codable {
    let name : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case url = "url"
    }
}

