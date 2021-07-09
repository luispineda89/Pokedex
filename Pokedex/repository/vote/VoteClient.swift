//
//  VoteClient.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import ComposableArchitecture
import Foundation

struct VoteClient {
    var pokemons: () -> Effect<[VotePokemonModel], Never>
    var save: (VotePokemonModel) -> ()
}

extension VoteClient {
    static var live = VoteClient(
        pokemons: {
            let models = VotePokemonModel.toModels(entities: PokemonDB.shared.get())
            return Effect(value: models)
        },
        save: { pokemon in
            PokemonDB.shared.save(pokemon: pokemon.toEntity())
        }
    )
}

#if DEBUG
// MARK: - MOCK
extension VoteClient {
    static let mock = VoteClient (
        pokemons: { Effect(value: .mock(2)) },
        save: { _ in }
    )
    
    static func mock(
        pokemons:  @escaping () -> Effect<[VotePokemonModel], Never> = { fatalError() },
        save: @escaping (VotePokemonModel) -> () = { _ in fatalError()}
    ) -> VoteClient {
        VoteClient(pokemons: pokemons,
                   save: save)
    }
}
#endif

