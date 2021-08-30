//
//  GenerationInteractor.swift
//  Pokedex
//
//  Created by Luis Pineda on 27/08/21.
//

import Foundation

protocol GenerationInteractorProtocol {
    func generation (id: Int,
                     success: @escaping ([PokemonModel])->(),
                     failure: @escaping (String)->()) -> ()
}

class GenerationInteractor: GenerationInteractorProtocol {
    
    private var repository: GenerationRepositoryProtocol
    
    init(repository: GenerationRepositoryProtocol = GenerationRepository()) {
        self.repository = repository
    }
    
    func generation(id: Int, success: @escaping ([PokemonModel]) -> (),
                    failure: @escaping (String) -> ()) {
        repository.generation(id: id, success: { pokemons in
            let pokemons = pokemons.sorted { $0.id < $1.id }
            success(pokemons)
        }, failure: failure)
    }
}
