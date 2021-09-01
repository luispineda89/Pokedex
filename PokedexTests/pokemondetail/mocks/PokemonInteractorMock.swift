//
//  PokemonInteractorMock.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import Foundation
@testable import Pokedex

class PokemonDetailInteractorMock: PokemonDetailInteractorProtocol {
    
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


}

class PokemonMoveInteractorMock: PokemonMoveInteractorProtocol {
    var type: MockType
    
    init(type: MockType) {
        self.type = type
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
