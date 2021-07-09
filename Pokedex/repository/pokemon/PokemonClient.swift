//
//  PokemonClient.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import ComposableArchitecture
import Foundation

struct PokemonClient {
    var pokemon: (Int) -> Effect<PokemonDetailModel, ErrorMessage>
    var pokemonSpecies: (String) -> Effect<PokemonSpeciesModel, ErrorMessage>
    var move: (String) -> Effect<MoveModel, ErrorMessage>
}

// MARK: - LIVE
extension PokemonClient {
    static var live = PokemonClient(
        pokemon: { pokemonId in
            return PokeAPI.send(Endpoint.pokemon(pokemonId))
        },
        pokemonSpecies: { url in
            return PokeAPI.send(Endpoint.pokemonSpecies(url))
        },
        move: { pokemonId in
            return PokeAPI.send(Endpoint.move(pokemonId))
        }
    )
}

#if DEBUG
// MARK: - MOCK
extension PokemonClient {
    static let mock = PokemonClient (
        pokemon: { _ in
            Effect(value: .mock)
        },
        pokemonSpecies: { _ in
            Effect(value: .mock)
        },
        move: { _ in
            Effect(value: .mock)
        }
    )

    static func mock(
        pokemon: @escaping (Int) -> Effect<PokemonDetailModel, ErrorMessage> = { _ in fatalError()},
        pokemonSpecies: @escaping (String) -> Effect<PokemonSpeciesModel, ErrorMessage> = { _ in fatalError()},
        move: @escaping (String) -> Effect<MoveModel, ErrorMessage> = { _ in fatalError()}
    ) -> PokemonClient {
        PokemonClient(pokemon: pokemon,
                      pokemonSpecies: pokemonSpecies,
                      move: move)
    }
}
#endif

