//
//  ResultContainer.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
class ResultContainer: Decodable {
    var count: Int
    var nextUrl: String
    var pokemon:[PokemonObject]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case nextUrl = "next"
        case results = "results"
    }
    
    init(count: Int, nextUrl: String, pokemon: [PokemonObject]) {
        self.count = count
        self.nextUrl = nextUrl
        self.pokemon = pokemon
    }
    
    required init(from decoder: Decoder) throws {
        pokemon = [PokemonObject]()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let count = try ((values.decodeIfPresent(Int.self, forKey: .count))) {
            self.count = count
        } else {
            self.count = 0
        }
        if let nextUrl = try ((values.decodeIfPresent(String.self, forKey: .nextUrl))) {
            self.nextUrl = nextUrl
        } else {
            self.nextUrl = ""
        }
        if let pokemon = try ((values.decodeIfPresent([PokemonObject].self, forKey: .results) ?? nil) ?? nil) {
            self.pokemon = pokemon
        } else {
            pokemon = [PokemonObject]()
        }
       
    }
}

