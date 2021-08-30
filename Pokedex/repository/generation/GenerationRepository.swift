//
//  GenerationRepository.swift
//  Pokedex
//
//  Created by Luis Pineda on 25/08/21.
//

import Foundation
import Combine

protocol GenerationRepositoryProtocol {
    func generation (id: Int,
                     success: @escaping ([PokemonModel])->(),
                     failure: @escaping (String)->()) -> ()
}

class GenerationRepository: GenerationRepositoryProtocol {

    private var cancellables = Set<AnyCancellable>()
    private var service: GenerationServiceProtocol
    
    init(service: GenerationServiceProtocol = GenerationService()) {
        self.service = service
    }
    
    func generation(id: Int,
                    success: @escaping ([PokemonModel]) -> (),
                    failure: @escaping (String) -> ()) {
        service.generation(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    failure(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { generation in
                let pokemons = generation.pokemon.map {
                    return PokemonModel(id: Pokemon.getId(url: $0.url),name: $0.name, url: $0.url)
                }
                success(pokemons)
            }
            .store(in: &cancellables)
    }
}
