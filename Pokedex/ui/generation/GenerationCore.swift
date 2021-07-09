//
//  GenerationCore.swift
//  Pokedex
//
//  Created by Luis Pineda on 6/07/21.
//

import Foundation
import ComposableArchitecture

enum GenerationType: Int {
    case i = 1
    case ii, iii, iv
    
    var text: String {
        switch self {
        case .i:
            return "I"
        case .ii:
            return "II"
        case .iii:
            return "III"
        case .iv:
            return "IV"
        }
    }
}

//MARK:- State
struct GenerationState: Equatable {
    var loading: Bool = false
    var didAppear = false
    var generation: GenerationType = .i
    var search: SearchState?
    var pokemons: [PokemonModel] = .mock(15)
    var _pokemons: [PokemonModel] = []
    var pokemonState: PokemonDetailState?
    var showAlert: Bool = false
    var alert: AlertModel = AlertModel()
    
    
    mutating func alertError(error: String) {
        self.alert.set(id: 1,
                       title: "Error!",
                       text: "Error: \(error).!",
                       textClose: "Cerrar",
                       type: .error)
    }
}

//MARK:- Action
enum GenerationAction: Equatable {
    case load
    case generationChage(GenerationType)
    case generationResponse(Result<GenerationModel,ErrorMessage>)
    case searchTapped
    case search(SearchAction)
    case pokemonActions(PokemonDetailAction)
    case setNavigationPokemon(selection: PokemonModel?)
    case showAlert(Bool)
}

//MARK:- Environment
struct GenerationEnvironment {
    var generationClient = GenerationClient.live
    var mainQueue = DispatchQueue.main.eraseToAnyScheduler()
}

extension GenerationEnvironment {
    var pokemon: PokemonDetailEnvironment {
        .init(mainQueue: mainQueue)
    }
}

//MARK:- Reducer
let generationReducer = Reducer<GenerationState, GenerationAction, GenerationEnvironment>.combine(
    searchReducer.optional().pullback(
        state: \.search,
        action: /GenerationAction.search,
        environment: { _ in SearchEnvironment() }
    ),
    pokemonDetailReducer.optional().pullback(
        state: \.pokemonState,
        action: /GenerationAction.pokemonActions,
        environment: \.pokemon
    ),
    Reducer {
        state, action, environment in
        struct GenerationId: Hashable {}
        switch action {
        case .load:
            if state.didAppear {
                return .none
            }
            state.didAppear = true
            state.loading = true
            return environment
                .generationClient
                .generation(state.generation.rawValue)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(GenerationAction.generationResponse)
                .cancellable(id: GenerationId())
        case .generationChage(let value):
            state.generation = value
            state.loading = true
            return environment
                .generationClient
                .generation(state.generation.rawValue)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(GenerationAction.generationResponse)
                .cancellable(id: GenerationId())
        case .searchTapped:
            state.search = .init(query: "")
            state._pokemons = state.pokemons
            return .none
        case .search(.queryChanged(let query)):
            if query.isEmpty {
                state.pokemons = state._pokemons
            } else {
                state.pokemons = state._pokemons.filter({ $0.name.lowercased().contains(query.lowercased()) })
            }
            return .none
        case .search(.cancel):
            state.search = nil
            state.pokemons = state._pokemons
            state._pokemons = []
            return .none
        case .generationResponse(.success(let generation)):
            state.pokemons = []
            state.loading = false
            var pokemons = generation.pokemon.map {
                return PokemonModel(id: Pokemon.getId(url: $0.url),name: $0.name, url: $0.url)
            }
            guard let search = state.search else {
                state.pokemons = pokemons.sorted { $0.id < $1.id }
                return .none
            }
            let query = search.query
            state._pokemons = pokemons.sorted { $0.id < $1.id }
            if query.isEmpty {
                state.pokemons = state._pokemons
            } else {
                state.pokemons = state._pokemons.filter({ $0.name.lowercased().contains(query.lowercased()) })
            }
            return .none
            
        case .generationResponse(.failure(let error)):
            state.loading = false
            state.alertError(error: error.message)
            state.showAlert = true
            return .none
        case .showAlert(let show):
            state.showAlert = show
            return .none
        case .setNavigationPokemon(selection: let pokemon):
            guard let pokemon = pokemon else {
                return .none
            }
            state.pokemonState = .init(pokemon: pokemon)
            return .none
        case .pokemonActions(.onDisappear):
            state.pokemonState = nil
            return .none
        case .pokemonActions(_):
            return .none
        }
    })
