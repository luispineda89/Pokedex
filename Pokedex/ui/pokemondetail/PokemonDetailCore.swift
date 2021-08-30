//
//  PokemonDetailCore.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import Foundation
import ComposableArchitecture
import SwiftUI

//MARK:- Action
enum PokemonDetailAction: Equatable {
    case load
    case pokemonResponse(Result<PokemonDetailModel,ErrorMessage>)
    case pokemonSpeciesResponse(Result<PokemonSpeciesModel,ErrorMessage>)
    case setNavigationMove(PokemonMoveModel)
    case moveActions(MoveDetailAction)
    case onDisappear
}

//MARK:- Environment
struct PokemonDetailEnvironment {
    var pokemonClient = PokemonClient.live
    var mainQueue = DispatchQueue.main.eraseToAnyScheduler()
}

extension PokemonDetailEnvironment {
    var move: MoveDetailEnvironment {
        .init(pokemonClient: pokemonClient,
              mainQueue: mainQueue)
    }
}

//MARK:- Reducer
let pokemonDetailReducer = Reducer<PokemonDetailState, PokemonDetailAction, PokemonDetailEnvironment>.combine(
    moveDetailReducer.optional().pullback(
        state: \.moveState,
        action: /PokemonDetailAction.moveActions,
        environment: \.move),

Reducer {
    state, action, environment in
    struct PokemonId: Hashable {}
    struct PokemonSpaciesId: Hashable {}
    switch action {
    case .load:
        return .concatenate(
            environment
                .pokemonClient
                .pokemon(state.pokemon.id)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(PokemonDetailAction.pokemonResponse)
                .cancellable(id: PokemonId()),
            environment
                .pokemonClient
                .pokemonSpecies(state.pokemon.url)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(PokemonDetailAction.pokemonSpeciesResponse)
                .cancellable(id: PokemonSpaciesId())
        )
        
    case .pokemonResponse(.success(let pokemon)):
        state.pokemonDetail = pokemon
        state.type = pokemon.getType()
        state.abilities = pokemon.abilities
        state.colorBackground = state.type[0].color
        return .none
    case .pokemonResponse(.failure(let error)):
        return .none
    case .pokemonSpeciesResponse(.success(let pokemon)):
        state.pokemonSpecies = pokemon
        return.none
    case .pokemonSpeciesResponse(.failure(let error)):
        return.none
    case .setNavigationMove(let move):
        state.moveState = .init(pokemonMove: move)
        return .none
    case .onDisappear:
        return .concatenate(
            .cancel(id: PokemonId()),
            .cancel(id: PokemonSpaciesId())
        )
    case .moveActions(.close):
        state.moveState = nil
        return .none
    case .moveActions(_):
        return .none
    }
})
