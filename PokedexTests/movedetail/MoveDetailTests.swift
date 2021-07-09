//
//  MoveDetailTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 8/07/21.
//

import XCTest
@testable import Pokedex
import ComposableArchitecture

class MoveDetailTests: XCTestCase {
    
    let testScheduler = DispatchQueue.test
    
    func testLoadSuccess() throws {
        let store = TestStore(initialState: MoveDetailState(pokemonMove: .mock),
                              reducer: moveDetailReducer,
                              environment: MoveDetailEnvironment(
                                pokemonClient: .mock(move: {_ in Effect(value: .mock)}),
                                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.load) {
                $0.loading = true
            },
            .do{ self.testScheduler.advance() },
            .receive(.moveResponse(.success(.mock))) {
                $0.loading = false
                $0.move = .mock
            }
        )
    }
    
    func testLoadFailure() throws {
        let store = TestStore(initialState: MoveDetailState(pokemonMove: .mock),
                              reducer: moveDetailReducer,
                              environment: MoveDetailEnvironment(
                                pokemonClient: .mock(move: {_ in Effect(error: ErrorMessage(404, "Page Not Found"))}),
                                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.load) {
                $0.loading = true
            },
            .do{ self.testScheduler.advance() },
            .receive(.moveResponse(.failure(ErrorMessage(404, "Page Not Found")))) {
                $0.loading = false
            }
        )
    }
}
