//
//  GenerartionTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 7/07/21.
//

import XCTest
@testable import Pokedex

class GenerartionTests: XCTestCase {
    
    func testLoadGenerationInREpository() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = GenerationRepository(service: GenerationServiceMock(generation: GenerationModel.mock))
        var pokemons2: [PokemonModel] = []
        repository.generation(id: 1) { pokemons in
            print("\(pokemons.count)")
            pokemons2 = pokemons
            exp.fulfill()
        } failure: { error in
            print(error)
        }
        waitForExpectations(timeout: 3)
        XCTAssertGreaterThanOrEqual(pokemons2.count, 2)
    }
    
    func testLoadSuccess() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = GenerationRepository(service: GenerationServiceMock(generation: GenerationModel.mock))
        let viewModel = GenerationViewModel(generationRepository: repository)
        viewModel.onAppear()
        XCTAssertTrue(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.generation, .i)
        XCTAssertEqual(viewModel.state.generation.text, "I")
        XCTAssertEqual(viewModel.state.pokemons.count, 15)
        _ = XCTWaiter.wait(for: [exp], timeout: 1.0) // wait and store the result
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
        XCTAssertFalse(viewModel.state.showAlert)
    }
    
    func testLoadError() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = GenerationRepository(service: GenerationServiceMock(generation: nil))
        let viewModel = GenerationViewModel(generationRepository: repository)
        viewModel.onAppear()
        XCTAssertTrue(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.generation, .i)
        XCTAssertEqual(viewModel.state.pokemons.count, 15)
        _ = XCTWaiter.wait(for: [exp], timeout: 1.0) // wait and store the result
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertTrue(viewModel.state.showAlert)
        XCTAssertEqual(viewModel.state.alert.title, "Error!")
    }
    
    func testSearch() throws {
        let exp = expectation(description: "expectation Search generation")
        let repository = GenerationRepository(service: GenerationServiceMock(generation: GenerationModel.mock))
        let viewModel = GenerationViewModel(generationRepository: repository)
        viewModel.onAppear()
        XCTAssertTrue(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.generation, .i)
        XCTAssertEqual(viewModel.state.pokemons.count, 15)
        _ = XCTWaiter.wait(for: [exp], timeout: 1.0) // wait and store the result
        viewModel.state.isSearch = true
        viewModel.state.query = "pokemon 1"
        XCTAssertEqual(viewModel.state.pokemonsAux.count, 2)
        XCTAssertEqual(viewModel.state.pokemons.count, 1)
        viewModel.state.isSearch = false
        XCTAssertEqual(viewModel.state.query, "")
        XCTAssertEqual(viewModel.state.pokemonsAux.count, 0)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
    }
    
    func testGenerationChangeSuccess() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = GenerationRepository(service: GenerationServiceMock(generation: GenerationModel.mock))
        let viewModel = GenerationViewModel(generationRepository: repository)
        viewModel.onAppear()
        XCTAssertTrue(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.generation, .i)
        XCTAssertEqual(viewModel.state.generation.text, "I")
        XCTAssertEqual(viewModel.state.pokemons.count, 15)
        _ = XCTWaiter.wait(for: [exp], timeout: 1.0) // wait and store the result
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
        XCTAssertFalse(viewModel.state.showAlert)
        let exp2 = expectation(description: "expectation Change generation")
        viewModel.generationChage(type: .ii)
        XCTAssertTrue(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.generation, .ii)
        XCTAssertEqual(viewModel.state.generation.text, "II")
        _ = XCTWaiter.wait(for: [exp2], timeout: 1.0) // wait and store the result
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
    }
    
}
