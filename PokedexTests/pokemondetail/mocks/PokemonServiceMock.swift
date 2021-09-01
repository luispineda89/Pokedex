//
//  PokemonServiceMock.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import Foundation
import  Combine
@testable import Pokedex

class PokemonServiceMock: PokemonServiceProtocol {
    
    var pokemonDetail: PokemonDetailModel?
    var pokemonSpecies: PokemonSpeciesModel?
    var move: MoveModel?
    
    init(pokemonDetail: PokemonDetailModel?,
         pokemonSpecies: PokemonSpeciesModel?,
         move: MoveModel?) {
        self.pokemonDetail = pokemonDetail
        self.pokemonSpecies = pokemonSpecies
        self.move = move
    }
    
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
