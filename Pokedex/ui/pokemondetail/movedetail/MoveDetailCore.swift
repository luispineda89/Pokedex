//
//  MoveDetailCore.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import Foundation
import ComposableArchitecture



//MARK:- Action
enum MoveDetailAction: Equatable {
    case load
    case moveResponse(Result<MoveModel,ErrorMessage>)
    case close
}

//MARK:- Environment
struct MoveDetailEnvironment {
    var pokemonClient: PokemonClient
    var mainQueue = DispatchQueue.main.eraseToAnyScheduler()
}

//MARK:- Reducer
let moveDetailReducer = Reducer<MoveDetailState, MoveDetailAction, MoveDetailEnvironment> {
    state, action, environment in
    
    struct MoveId: Hashable {}
    switch action {
    case .load:
        state.loading = true
        return environment
            .pokemonClient
            .move(state.pokemonMove.move.getId())
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(MoveDetailAction.moveResponse)
            .cancellable(id: MoveId())
    case .moveResponse(.success(let move)):
        state.loading = false
        state.move = move
        return .none
    case .moveResponse(.failure(let error)):
        state.loading = false
        return .none
    case .close:
        return .cancel(id: MoveId())
    }
}

