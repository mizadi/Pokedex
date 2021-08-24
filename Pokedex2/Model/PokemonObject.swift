//
//  PokemonObject.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
class PokemonObject: Decodable {
    let name: String
    let url: String
    var sprites: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
        case sprites = "sprites"
        case frontDefault = "front_default"
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
        self.sprites = [String]()
    }
    
    required init(from decoder: Decoder) throws {
        sprites = [String]()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let name = try ((values.decodeIfPresent(String.self, forKey: .name))) {
            self.name = name
        } else {
            self.name = ""
        }
        if let url = try ((values.decodeIfPresent(String.self, forKey: .url))) {
            self.url = url
        } else {
            self.url = ""
        }
    }
    
    func addSprite(_ string: String) {
        sprites.append(string)
    }
}
