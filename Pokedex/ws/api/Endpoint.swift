//
//  Endpoint.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import Foundation

struct Endpoint {
    
    static private let baseURL = "https://pokeapi.co/api/v2/"
    static private let urlSpritesAnimated = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/%d.gif"
    
    private enum EndpointType: String {
        case generation = "generation/%d"
    }
    
    static func generation(_ generation: Int) -> URLRequest {
        return URLRequest(url: URL(string: String(format: baseURL + EndpointType.generation.rawValue, generation))!)
    }
    
    static func urlSprinteAnimated(id: Int) -> URL {
        return URL(string: String(format: urlSpritesAnimated, id))!
    }
    
    
}
