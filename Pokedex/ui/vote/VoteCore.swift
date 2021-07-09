//
//  VoteCore.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import SwiftUI
import Combine
import ComposableArchitecture

//MARK:- State
struct VoteState: Equatable {
    var loading: Bool = false
    var generation: GenerationType
    var pokemonsGeneration: [PokemonModel]
    var pokemons: [Int] = []
    var pokeDetails: [PokemonDetailModel] = []
    var pokemonLocals: [VotePokemonModel] = []
    var showAlert: Bool = false
    var alert: AlertModel = AlertModel()
    
    
    mutating func alertVoteEmpty() {
        self.alert.set(id: 1,
                       title: "No Pokemon!",
                       text: "No tienes Pokémon de la Generacion \(generation.text), para votar.!",
                       textClose: "Cerrar",
                       type: .error)
    }
}

//MARK:- Action
enum VoteAction: Equatable {
    case load
    case save(PokemonDetailModel, LikeDislike)
    case details
    case detailsResponse(Result<PokemonDetailModel,ErrorMessage>)
    case pokemonsLocalResponse(Result<[VotePokemonModel], Never>)
    case showAlert(Bool)
}

//MARK:- Environment
struct VoteEnvironment {
    var pokemonClient = PokemonClient.live
    var voteClient = VoteClient.live
    var mainQueue = DispatchQueue.main.eraseToAnyScheduler()
}

//MARK:- Reducer
let voteReducer = Reducer<VoteState, VoteAction, VoteEnvironment> {
    state, action, environment in
    struct pokeDetailId: Hashable {}
    switch action {
    case .load:
        return environment
            .voteClient
            .pokemons()
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(VoteAction.pokemonsLocalResponse)
    case .pokemonsLocalResponse(.success(let pokemons)):
            state.pokemonLocals = pokemons.sorted { $0.id < $1.id }
        return .none
        
    case .details:
        state.pokemons = []
        state.pokeDetails = []
        state.loading = true
        
        let idsLocales = Set(state.pokemonLocals.map { $0.id })
        var webIds = Set(state.pokemonsGeneration.map { $0.id })
        
        webIds.subtract(idsLocales)

        state.pokemons = Array(webIds.shuffled().prefix(10))
        if state.pokemons.isEmpty {
            state.alertVoteEmpty()
            state.showAlert = true
            return .none
        }
        return .concatenate(
            state.pokemons.map {
                environment
                .pokemonClient
                .pokemon($0)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(VoteAction.detailsResponse)
                .cancellable(id: pokeDetailId())
            }
        )
    case .detailsResponse(.success(let pokemon)):
        state.pokeDetails.append(pokemon)
        if state.pokemons.count == state.pokeDetails.count {
            state.loading = false
        }
        return .none
    case .detailsResponse(.failure(let error)):
        state.loading = false
        //TODO: Manejar el error
        return .none
    case let .save(pokemon, likeDislike):
        state.pokeDetails.removeAll {
            $0.id == pokemon.id
        }
        var model = VotePokemonModel(id: pokemon.id,
                                     name: pokemon.name,
                                     generation: state.generation,
                                     likeDislike: likeDislike)
        environment
            .voteClient
            .save(model)
        state.pokemonLocals.append(model)
        state.pokemonLocals = state.pokemonLocals.sorted { $0.id < $1.id }
        return .none
    case .showAlert(let show):
        state.showAlert = show
        return .none
    }
}.debug()
