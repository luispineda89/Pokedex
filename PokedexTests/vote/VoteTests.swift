//
//  VoteTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 9/07/21.
//

import XCTest
@testable import Pokedex
import ComposableArchitecture

class VoteTests: XCTestCase {
    
    let testScheduler = DispatchQueue.test

    func testLoad() throws {
        let store = TestStore(initialState: VoteState(generation: .i, pokemonsGeneration: .mock(2)),
                              reducer: voteReducer,
                              environment: VoteEnvironment(
                                pokemonClient: .mock,
                                voteClient: .mock(
                                    pokemons: { Effect(value: .mock(2))}),
                                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.load),
                .do{ self.testScheduler.advance() },
            .receive(.pokemonsLocalResponse(.success(.mock(2)))){
                $0.pokemonLocals = .mock(2)
            }
        )
    }
    
    func testVoteSave() throws {
        let store = TestStore(initialState: VoteState(generation: .i, pokemonsGeneration: .mock(2), pokeDetails: .mock(2)),
                              reducer: voteReducer,
                              environment: VoteEnvironment(
                                pokemonClient: .mock,
                                voteClient: .mock( save: { _ in
                                        ()
                                    }),
                                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.save(.mock, .like)) {
                $0.pokeDetails = [
                    .mock(id: 2,
                          name: "pokemon 2",
                          weight: 8,
                          height: 27,
                          pokedexId: 2,
                          types: .mock(2),
                          abilities: .mock(2),
                          moves: .mock(2))
                ]
                $0.pokemonLocals = .mock(1)
            }
                
        )
    }
    
    
    func testDetailsVoteEmpty() throws {
        let store = TestStore(initialState: VoteState(generation: .i, pokemonsGeneration: .mock(2), pokemonLocals: .mock(2)),
                              reducer: voteReducer,
                              environment: VoteEnvironment(
                                pokemonClient: .mock,
                                voteClient: .mock( save: { _ in
                                        ()
                                    }),
                                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.details) {
                $0.loading = true
                $0.alertVoteEmpty()
                $0.showAlert = true
            },
            .send(.showAlert(false)) {
                $0.showAlert = false
            }
                
        )
    }
    
    
    
    
}





























































































