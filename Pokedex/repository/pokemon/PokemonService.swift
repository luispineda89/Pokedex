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

//MARK:- Mock
#if DEBUG
class PokemonServiceMock: PokemonServiceProtocol {
    
    var pokemonDetail: PokemonDetailModel?
    var pokemonSpecies: PokemonSpeciesModel?
    var move: MoveModel?
    
    func pokemon(id: Int) -> AnyPublisher<PokemonDetailModel, Error> {
        guard let pokemonDetail = pokemonDetail else {
            return Result<PokemonDetailModel, Error>.Publisher(URLError(.timedOut)).eraseToAnyPublisher()
        }
        return Result<PokemonDetailModel, Error>.Publisher(pokemonDetail).eraseToAnyPublisher()
    }
    
    func pokemonSpecies(url: String) -> AnyPublisher<PokemonSpeciesModel, Error> {
        guard let pokemonSpecies = pokemonSpecies else {
            return Result<PokemonSpeciesModel, Error>.Publisher(URLError(.timedOut)).eraseToAnyPublisher()
        }
        return Result<PokemonSpeciesModel, Error>.Publisher(pokemonSpecies).eraseToAnyPublisher()
    }
    
    func move(id: String) -> AnyPublisher<MoveModel, Error> {
        guard let move = move else {
            return Result<MoveModel, Error>.Publisher(URLError(.timedOut)).eraseToAnyPublisher()
        }
        return Result<MoveModel, Error>.Publisher(move).eraseToAnyPublisher()
    }
}
#endif
