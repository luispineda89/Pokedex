//
//  GenerationModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import Foundation

struct GenerationModel: Identifiable, Hashable, Codable {
    var id: Int
    var pokemon: [Pokemon] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case pokemon = "pokemon_species"
    }
}

struct  Pokemon: Hashable, Codable  {
    var name: String = ""
    var url: String = ""
    
    static func getId(url: String) -> Int {
        let id = URL(string: url)?.lastPathComponent ?? "0"
        return Int(id) ?? .zero
    }
}

//MARK:- Mock
#if DEBUG
extension GenerationModel {
    static var mock = GenerationModel(id: 1, pokemon: .mock(2))
    
    static func mock(id: Int, pokemon: [Pokemon]) -> GenerationModel {
        GenerationModel(id: id,
                        pokemon: pokemon)
    }
    
}

extension Pokemon {
    static var mock = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/")
    
}
extension Array where Element == Pokemon {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            Pokemon(name: "pokemon \($0)", url: "https://pokeapi.co/api/v2/pokemon-species/\($0)/")
        }
    }
}

#endif
