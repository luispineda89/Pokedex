//
//  PokemonRepositoryMock.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import Foundation
@testable import Pokedex

class PokemonRepositoryMock: PokemonRepositoryProtocol  {
    
    var type: MockType
    
    init(type: MockType) {
        self.type = type
    }
    
    func pokemon(id: Int,
                 success: @escaping (PokemonDetailModel) -> (),
                 failure: @escaping (String) -> ()) {
        if type == .success {
            success(.mock)
        } else {
            failure("Error")
        }
    }
    
    func pokemonSpecies(url: String,
                        success: @escaping (PokemonSpeciesModel) -> (),
                        failure: @escaping (String) -> ()) {
        if type == .success {
            success(.mock)
        } else {
            failure("Error")
        }
    }
    
    func move(id: String,
              success: @escaping (MoveModel) -> (),
              failure: @escaping (String) -> ()) {
        if type == .success {
            success(.mock)
        } else {
            failure("Error")
        }
    }

}
