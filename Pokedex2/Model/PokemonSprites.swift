//
//  PokemonSprites.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
//class PokemonSprites: Decodable {
//    
//    var frontDefault: String
//    
//    enum CodingKeys: String, CodingKey {
//        case frontDefault = "front_default"
//        case sprites = "sprites"
//    }
//    
//    init(frontDefault: String) {
//        self.frontDefault = frontDefault
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
////        if let sprites = try((values.decodeIfPresent([String: String?].self, forKey: .sprites))) {
////            self.frontDefault = (sprites[CodingKeys.frontDefault.rawValue] ?? "") ?? ""
////        } else {
////            self.frontDefault = ""
////        }
//        let superDecoder = try values.superDecoder(forKey: .sprites)
//        let superValues = try superDecoder.container(keyedBy: CodingKeys.self)
//        if let sprite = try superValues.decodeIfPresent(String.self, forKey: .frontDefault) {
//            self.frontDefault = sprite
//        } else {
//            self.frontDefault = ""
//        }
//       
//    }
//}
