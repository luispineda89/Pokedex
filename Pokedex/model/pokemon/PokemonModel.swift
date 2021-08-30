//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 6/07/21.
//

import Foundation

struct PokemonModel: Identifiable, Hashable, Codable, Equatable {
    var id: Int
    var name: String
    var url: String
    
    init(id: Int = 1,
         name: String = "",
         url: String = "") {
    self.id = id
    self.name = name
    self.url = url
    }
}

//MARK:- Mock
#if DEBUG
extension PokemonModel {
    static var mock = PokemonModel(id: 1,
                                   name: "bulbasaur",
                                   url: "https://pokeapi.co/api/v2/pokemon-species/1/")
    
    func mock(id: Int,
              name: String,
              url: String) -> PokemonModel {
        PokemonModel(id: id, name: name, url: url)
    }
    
}
extension Array where Element == PokemonModel {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            PokemonModel(id: $0,
                         name: "pokemon \($0)",
                         url: "https://pokeapi.co/api/v2/pokemon-species/\($0)/")
        }
    }
}
#endif
