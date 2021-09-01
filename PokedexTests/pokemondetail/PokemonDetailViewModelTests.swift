//
//  PokemonDetailViewModelTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 8/07/21.
//

import XCTest
@testable import Pokedex

class PokemonDetailViewModelTests: XCTestCase {

    func testLoadSuccess() throws {
        let interactor = PokemonDetailInteractorMock(type: .success)
        let viewModel = PokemonDetailViewModel(state: PokemonDetailState(pokemon: .mock),
                                               pokemonInteractor: interactor)
        viewModel.onAppear()
        //getPokemon
        XCTAssertFalse(viewModel.state.isMoveShow)
        XCTAssertEqual(viewModel.state.type, [PokemonType.grass,PokemonType.grass])
        XCTAssertEqual(viewModel.state.colorBackground, PokemonType.grass.color)
        //getPokemonSpecies
        XCTAssertEqual(viewModel.state.pokemonSpecies, .mock)
    }
    
    func testLoadFailure() throws {
        let interactor = PokemonDetailInteractorMock(type: .failure)
        let viewModel = PokemonDetailViewModel(state: PokemonDetailState(pokemon: .mock),
                                               pokemonInteractor: interactor)
        viewModel.onAppear()
        //TODO: hacer la implementacion de los casos de error en la aplicacion
        //getPokemon
        //getPokemonSpecies
    }
    
    
 
}
