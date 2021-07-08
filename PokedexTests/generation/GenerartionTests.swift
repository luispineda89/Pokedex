//
//  GenerartionTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 7/07/21.
//

import XCTest
@testable import Pokedex
import ComposableArchitecture

class GenerartionTests: XCTestCase {
    let testScheduler = DispatchQueue.test
    
    func testLoadSuccess() throws {
        let store = TestStore(
            initialState: GenerationState(),
            reducer: generationReducer,
            environment: GenerationEnvironment(
                generationClient: .mock(generation: { _ in Effect(value: .mock)} ),
                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.load) {
                $0.didAppear = true
                $0.loading = true
            },
            .do { self.testScheduler.advance() },
            .receive(.generationResponse(.success(.mock))) {
                $0.pokemons = .mock(2)
                $0.loading = false
            },
            .send(.load)
        )
    }
    
    func testLoadError() throws {
        let store = TestStore(
            initialState: GenerationState(),
            reducer: generationReducer,
            environment: GenerationEnvironment(
                generationClient: .mock(generation: { _ in Effect(error: ErrorMessage(404, "Page Not Found"))} ),
                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.load) {
                $0.didAppear = true
                $0.loading = true
            },
            .do { self.testScheduler.advance() },
            .receive(.generationResponse(.failure(ErrorMessage(404, "Page Not Found")))) {
                $0.loading = false
                $0.alert = AlertModel(title: "Error!",
                                      text: "Error: Page Not Found.!",
                                      textClose: "Cerrar",
                                      textConfirm: "TEXT_CONFIRM",
                                      type: AlertType.error)
                $0.showAlert = true
            },
            .send(.showAlert(false)) {
                $0.showAlert = false
            }
        )
    }
    
    func testGenerationChange() throws {
        let store = TestStore(
            initialState: GenerationState(generation: .i, pokemons: .mock(2)),
            reducer: generationReducer,
            environment: GenerationEnvironment(
                generationClient: .mock(generation: { _ in Effect(value: .mock(id: 2, pokemon: .mock(3)))} ),
                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.generationChage(GenerationType.ii)) {
                $0.generation = GenerationType.ii
                XCTAssertEqual($0.generation.text, "II")
                $0.loading = true
            },
            .do { self.testScheduler.advance() },
            .receive(.generationResponse(.success(.mock(id: 2, pokemon: .mock(3))))) {
                $0.pokemons = .mock(3)
                $0.loading = false
                
            }
        )
    }
    
    func testSearchSuccess() throws {
        let store = TestStore(
            initialState: GenerationState(pokemons: .mock(2)),
            reducer: generationReducer,
            environment: GenerationEnvironment(
                generationClient: .mock,
                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.searchTapped) {
                $0.search = .init(query: "")
                $0._pokemons = $0.pokemons
            },
            .send(.search(.queryChanged(""))),
            .send(.search(.queryChanged("pokemon 2"))) {
                $0.search?.query = "pokemon 2"
                $0.pokemons = [PokemonModel(id: 2,
                                            name: "pokemon 2",
                                            url: "https://pokeapi.co/api/v2/pokemon-species/2/")]
                
            },
            .send(.search(.queryChanged(""))) {
                $0.search?.query = ""
                $0.pokemons = $0._pokemons
            },
            .send(.search(.cancel)) {
                $0.search?.query = ""
                $0.pokemons = $0._pokemons
                $0._pokemons = []
                $0.search = nil
                
            }
        )
    }
    
    func testGenerationChangeAndSearch() throws {
        let store = TestStore(
            initialState: GenerationState(generation: .i, search: SearchState(query: "pokemon 2"), pokemons: .mock(2)),
            reducer: generationReducer,
            environment: GenerationEnvironment(
                generationClient: .mock(generation: { _ in Effect(value: .mock(id: 2, pokemon: .mock(3)))} ),
                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.generationChage(GenerationType.ii)) {
                $0.generation = GenerationType.ii
                $0.loading = true
            },
            .do { self.testScheduler.advance() },
            .receive(.generationResponse(.success(.mock(id: 2, pokemon: .mock(3))))) {
                $0.loading = false
                $0._pokemons = .mock(3)
                $0.search?.query = "pokemon 2"
                $0.pokemons = [PokemonModel(id: 2, name: "pokemon 2", url: "https://pokeapi.co/api/v2/pokemon-species/2/")]
            }
        )
    }
    
    func testGenerationChangeAndSearchEmpty() throws {
        let store = TestStore(
            initialState: GenerationState(generation: .i, search: SearchState(query: ""), pokemons: .mock(2)),
            reducer: generationReducer,
            environment: GenerationEnvironment(
                generationClient: .mock(generation: { _ in Effect(value: .mock(id: 2, pokemon: .mock(3)))} ),
                mainQueue: testScheduler.eraseToAnyScheduler())
        )
        store.assert(
            .send(.generationChage(GenerationType.ii)) {
                $0.generation = GenerationType.ii
                $0.loading = true
            },
            .do { self.testScheduler.advance() },
            .receive(.generationResponse(.success(.mock(id: 2, pokemon: .mock(3))))) {
                $0.loading = false
                $0._pokemons = .mock(3)
                $0.pokemons = .mock(3)
            }
        )
    }
}
