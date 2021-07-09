//
//  PokemonDetailTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 8/07/21.
//

import XCTest
@testable import Pokedex
import ComposableArchitecture

class PokemonDetailTests: XCTestCase {
    let testScheduler = DispatchQueue.test

    func testLoadSuccess() throws {
        let store = TestStore(initialState: PokemonDetailState(pokemon: .mock),
                              reducer: pokemonDetailReducer,
                              environment: PokemonDetailEnvironment(
                                pokemonClient: .mock(
                                    pokemon: { _ in Effect(value: .mock)},
                                    pokemonSpecies: { _ in Effect(value: .mock)}),
                                mainQueue: testScheduler.eraseToAnyScheduler()
                              )
        )
        store.assert(
            .send(.load),
            .do{ self.testScheduler.advance() },
            .receive(.pokemonResponse(.success(.mock))) {
                $0.pokemonDetail = .mock
                $0.type = $0.pokemonDetail.getType()
                $0.abilities = $0.pokemonDetail.abilities
                $0.colorBackground = $0.type[0].color
            },
            .receive(.pokemonSpeciesResponse(.success(.mock))) {
                $0.pokemonSpecies = .mock
            }
        )
    }
    
    func testLoadFailure() throws {
        let store = TestStore(initialState: PokemonDetailState(pokemon: .mock),
                              reducer: pokemonDetailReducer,
                              environment: PokemonDetailEnvironment(
                                pokemonClient: .mock(
                                    pokemon: { _ in Effect(error: ErrorMessage(404, "Page Not Found"))},
                                    pokemonSpecies: { _ in Effect(error: ErrorMessage(404, "Page Not Found"))}),
                                mainQueue: testScheduler.eraseToAnyScheduler()
                              )
        )
        store.assert(
            .send(.load),
            .do{ self.testScheduler.advance() },
            .receive(.pokemonResponse(.failure(ErrorMessage(404, "Page Not Found")))) ,
            .receive(.pokemonSpeciesResponse(.failure(ErrorMessage(404, "Page Not Found"))))
        )
    }
    
    func testNavigationMove() throws {
        let store = TestStore(initialState: PokemonDetailState(pokemon: .mock),
                              reducer: pokemonDetailReducer,
                              environment: PokemonDetailEnvironment(
                                pokemonClient: .mock,
                                mainQueue: testScheduler.eraseToAnyScheduler()
                              )
        )
        store.assert(
            .send(.setNavigationMove(.mock)) {
                $0.moveState = .init(pokemonMove: .mock)
            },
            .send(.moveActions(.close)) {
                $0.moveState = nil
            }
        )
    }
}
