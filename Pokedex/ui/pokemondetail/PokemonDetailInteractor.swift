//
//  PokemonDetailInteractor.swift
//  Pokedex
//
//  Created by Luis Pineda on 27/08/21.
//

import Foundation


protocol PokemonDetailInteractorProtocol {
    func pokemon(id: Int,
                 success: @escaping (PokemonDetailModel)->(),
                 failure: @escaping (String)->()) -> ()
    func pokemonSpecies(url: String,
                        success: @escaping (PokemonSpeciesModel)->(),
                        failure: @escaping (String)->()) -> ()
}

protocol PokemonMoveInteractorProtocol {
    func move(id: String,
              success: @escaping (MoveModel)->(),
              failure: @escaping (String)->()) -> ()
}

class PokemonInteractor: PokemonDetailInteractorProtocol, PokemonMoveInteractorProtocol  {
    
    private var repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol = PokemonRepository()) {
        self.repository = repository
    }
    
    
    func pokemon(id: Int,
                 success: @escaping (PokemonDetailModel) -> (),
                 failure: @escaping (String) -> ()) {
        repository.pokemon(id: id, success: success, failure: failure)
    }
    
    func pokemonSpecies(url: String,
                        success: @escaping (PokemonSpeciesModel) -> (),
                        failure: @escaping (String) -> ()) {
        repository.pokemonSpecies(url: url, success: success, failure: failure)
    }
    
    func move(id: String,
              success: @escaping (MoveModel) -> (),
              failure: @escaping (String) -> ()) {
        repository.move(id: id, success: success, failure: failure)
    }
   
}
