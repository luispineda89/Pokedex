//
//  GenerartionViewModelTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 7/07/21.
//

import XCTest
@testable import Pokedex

class GenerartionViewModelTests: XCTestCase {
    
    func testLoadSuccess() throws {
        let interactor = GenerationInteractorMock(type: .success)
        let viewModel = GenerationViewModel(generationInteractor: interactor)
        viewModel.onAppear()
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
        XCTAssertFalse(viewModel.state.showAlert)
    }
    
    func testLoadError() throws {
        let interactor = GenerationInteractorMock(type: .failure)
        let viewModel = GenerationViewModel(generationInteractor: interactor)
        viewModel.onAppear()
        XCTAssertEqual(viewModel.state.generation, .i)
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertTrue(viewModel.state.showAlert)
        XCTAssertEqual(viewModel.state.alert.title, "Error!")
    }
    
    func testSearch() throws {
        let interactor = GenerationInteractorMock(type: .success)
        let viewModel = GenerationViewModel(generationInteractor: interactor)
        viewModel.onAppear()
        XCTAssertEqual(viewModel.state.generation, .i)
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
        let interactor = GenerationInteractorMock(type: .success)
        let viewModel = GenerationViewModel(generationInteractor: interactor)
        viewModel.onAppear()
        XCTAssertEqual(viewModel.state.generation, .i)
        XCTAssertEqual(viewModel.state.generation.text, "I")
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
        XCTAssertFalse(viewModel.state.showAlert)
        viewModel.generationChage(type: .ii)
        XCTAssertEqual(viewModel.state.generation, .ii)
        XCTAssertEqual(viewModel.state.generation.text, "II")
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
        viewModel.generationChage(type: .iii)
        XCTAssertEqual(viewModel.state.generation, .iii)
        XCTAssertEqual(viewModel.state.generation.text, "III")
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
        viewModel.generationChage(type: .iv)
        XCTAssertEqual(viewModel.state.generation, .iv)
        XCTAssertEqual(viewModel.state.generation.text, "IV")
        XCTAssertFalse(viewModel.state.loading)
        XCTAssertEqual(viewModel.state.pokemons.count, 2)
    }
    
}
