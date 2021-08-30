//
//  GenerationRepositoryMock.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import Foundation
@testable import Pokedex

class GenerationRepositoryMock: GenerationRepositoryProtocol {
    
    var type: MockType
    
    init(type: MockType) {
        self.type = type
    }
    
    func generation(id: Int,
                    success: @escaping ([PokemonModel]) -> (),
                    failure: @escaping (String) -> ()) {
        if type == .success {
            success(.mock(10).shuffled())
        } else {
            failure("Error")
        }
        
    }
}
