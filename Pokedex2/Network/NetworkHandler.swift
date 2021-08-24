//
//  NetworkHandler.swift
//  Pokedex2
//
//  Created by Adi Mizrahi on 07/07/2021.
//

import Foundation
protocol Endpoint {
    /// HTTP or HTTPS
    var scheme: String {
        get
    }
    // Example: "api.flickr.com"
    var baseURL: String {
        get
    }
    // "/services/rest/"
    var path: String {
        get
    }
    // [URLQueryItem(name: "api_key", value: API_KEY)]
    var parameters: [URLQueryItem] {
        get
    }
    // "GET"
    var method: String {
        get
    }
}
//url    String    "https://pokeapi.co/api/v2/pokemon/1/"
enum PokemonEndPoint: Endpoint {
    case pullPokemonContainer(limit: String)
    case pullMorePokemon(url: String)
    case pullSinglePokemon(url: String)
    var scheme: String {
        switch self {
        default: return "https"
        }
    }
    var baseURL: String {
        switch self {
        default: return "pokeapi.co"
        }
    }
    var path: String {
        switch self {
        case.pullPokemonContainer:
            return "/api/v2/pokemon"
        case.pullMorePokemon:
            return "/api/v2/pokemon"
        case.pullSinglePokemon(let url):
            let tempURL = URL(string: url)
            return tempURL!.path
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case.pullPokemonContainer(let limit):
            return [URLQueryItem(name: "limit", value: limit)]
        case.pullMorePokemon(let url):
            let offset = URLHelper.shared.getQueryStringParameter(url: url, param: "offset")
            return [URLQueryItem(name: "limit", value: "150"),
                    URLQueryItem(name: "offset", value: offset)]
        case.pullSinglePokemon:
            return []
        }
        
        
    }
    var method: String {
        switch self {
        case.pullPokemonContainer:
            return "GET"
        case.pullMorePokemon:
            return "GET"
        case.pullSinglePokemon:
            return "GET"
        }
    }
    
}


