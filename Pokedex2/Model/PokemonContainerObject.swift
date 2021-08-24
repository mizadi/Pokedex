//
//  PokemonContainerObject.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 08/07/2021.
//

import Foundation

protocol PokemonContainer {
    var count: Int32 { get }
    var next: String { get }
    var previous: String { get }
    var results: [PokemonResultPage] { get }
}

struct PokemonContainerResponse: Codable {
    var count: Int32
    var next: String?
    var previous: String?
    var results: [PokemonResultPage]
}

struct PokemonResultPage: Codable {
    let name: String
    let url: String
    var sprites: [String]?
    //var sprites: [String]
    mutating func addSpirte(_ sprite: String) {
        if sprites == nil {
            sprites = [String]()
        }
        sprites?.append(sprite)
    }
}

struct PokemonSprites: Codable {
    var frontDefault: String
    var sprites: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case sprites = "sprites"
    }
    
    init(frontDefault: String) {
        self.frontDefault = frontDefault
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let superDecoder = try values.superDecoder(forKey: .sprites)
        let superValues = try superDecoder.container(keyedBy: CodingKeys.self)
        if let sprite = try superValues.decodeIfPresent(String.self, forKey: .frontDefault) {
            self.frontDefault = sprite
        } else {
            self.frontDefault = ""
        }
        
    }
}
