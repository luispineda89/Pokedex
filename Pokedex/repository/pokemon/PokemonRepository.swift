//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Luis Pineda on 25/08/21.
//

import Foundation
import Combine

protocol PokemonRepositoryProtocol {
    func pokemon(id: Int,
                 success: @escaping (PokemonDetailModel)->(),
                 failure: @escaping (String)->()) -> ()
    func pokemonSpecies(url: String,
                        success: @escaping (PokemonSpeciesModel)->(),
                        failure: @escaping (String)->()) -> ()
    func move(id: String,
              success: @escaping (MoveModel)->(),
              failure: @escaping (String)->()) -> ()
}

class PokemonRepository: PokemonRepositoryProtocol  {
    
    private var cancellables = Set<AnyCancellable>()
    private var service: PokemonServiceProtocol
    
    init(service: PokemonServiceProtocol = PokemonService()) {
        self.service = service
    }
    
    
    func pokemon(id: Int,
                 success: @escaping (PokemonDetailModel) -> (),
                 failure: @escaping (String) -> ()) {
        service.pokemon(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    failure(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { pokemon in
                success(pokemon)            }
            .store(in: &cancellables)
    }
    
    func pokemonSpecies(url: String,
                        success: @escaping (PokemonSpeciesModel) -> (),
                        failure: @escaping (String) -> ()) {
        service.pokemonSpecies(url: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    failure(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { pokemon in
                success(pokemon)
            }
            .store(in: &cancellables)
    }
    
    func move(id: String, success: @escaping (MoveModel) -> (), failure: @escaping (String) -> ()) {
        service.move(id: id)
            .receive(on: DispatchQueue.main)
            .sink { complete in
                switch complete {
                case .failure(let error):
                    failure(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { move in
                success(move)
            }.store(in: &cancellables)
    }
    
    
}
