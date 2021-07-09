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
    static private let urlSprinteOfficial = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%d.png"
    
    private enum EndpointType: String {
        case generation = "generation/%d"
        case pokemon = "pokemon/%d"
        case move = "move/%@"
    }
    
    static func generation(_ generation: Int) -> URLRequest {
        return URLRequest(url: URL(string: String(format: baseURL + EndpointType.generation.rawValue, generation))!)
    }
    
    static func pokemon(_ pokemonId: Int) -> URLRequest {
        return URLRequest(url: URL(string: String(format: baseURL + EndpointType.pokemon.rawValue, pokemonId))!)
    }
    
    static func pokemonSpecies(_ url: String) -> URLRequest {
        return URLRequest(url: URL(string: url)!)
    }
    
    static func move(_ pokemonId: String) -> URLRequest {
        return URLRequest(url: URL(string: String(format: baseURL + EndpointType.move.rawValue, pokemonId))!)
    }
    
    static func urlSprinteAnimated(id: Int) -> URL {
        return URL(string: String(format: urlSpritesAnimated, id))!
    }
    
    static func urlSprinteOfficial(id: Int) -> URL {
        return URL(string: String(format: urlSprinteOfficial, id))!
    }
    
}
