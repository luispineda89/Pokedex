//
//  PokemonService.swift
//  Pokedex
//
//  Created by Luis Pineda on 20/08/21.
//

import Foundation
import Combine

protocol  PokemonServiceProtocol {
    func pokemon (id:Int) -> AnyPublisher<PokemonDetailModel, Error>
    func pokemonSpecies (url: String) -> AnyPublisher<PokemonSpeciesModel, Error>
    func move (id: String) -> AnyPublisher<MoveModel, Error>
}

class PokemonService: PokemonServiceProtocol {
    private var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func pokemon(id: Int) -> AnyPublisher<PokemonDetailModel, Error> {
        return network.get(type: PokemonDetailModel.self,
                           urlRequest: Endpoint.pokemon(id))
    }
    
    func pokemonSpecies(url: String) -> AnyPublisher<PokemonSpeciesModel, Error> {
        return network.get(type: PokemonSpeciesModel.self,
                           urlRequest: Endpoint.pokemonSpecies(url))
    }
    
    func move(id: String) -> AnyPublisher<MoveModel, Error> {
        return network.get(type: MoveModel.self,
                           urlRequest: Endpoint.move(id))
    }
}
