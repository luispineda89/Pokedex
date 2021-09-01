//
//  PokemonDetailInteractorTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import XCTest
@testable import Pokedex

class PokemonDetailInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadPokemonInRepositorySuccess() throws {
        let interactor = PokemonInteractor(repository: PokemonRepositoryMock(type: .success))
        var pokemonFinal: PokemonDetailModel = .init()
        
        interactor.pokemon(id: 1) { pokemon in
            pokemonFinal = pokemon
        } failure: { error in
        }
        XCTAssertEqual(pokemonFinal, PokemonDetailModel.mock)
    }
    
    func testLoadPokemonInRepositoryFailure() throws {
        let interactor = PokemonInteractor(repository: PokemonRepositoryMock(type: .failure))
        var errorfinal: String = ""
        interactor.pokemon(id: 1) { pokemon in
        } failure: { error in
            errorfinal = "Error"
        }
        XCTAssertEqual(errorfinal, "Error")
    }
    
    func testLoadPokemonSpeciesInRepositorySuccess() throws {
        let interactor = PokemonInteractor(repository: PokemonRepositoryMock(type: .success))
        var pokemonFinal: PokemonSpeciesModel = .init()
        
        interactor.pokemonSpecies(url: "") { pokemon in
            pokemonFinal = pokemon
        } failure: { error in
            
        }
        XCTAssertEqual(pokemonFinal, PokemonSpeciesModel.mock)
    }
    
    func testLoadPokemonSpeciesInRepositoryFailure() throws {
        let interactor = PokemonInteractor(repository: PokemonRepositoryMock(type: .failure))
        var errorfinal: String = ""
        interactor.pokemonSpecies(url: "") { pokemon in
        } failure: { error in
            errorfinal = "Error"
        }
        XCTAssertEqual(errorfinal, "Error")
    }
    
    func testLoadMoveInRepositorySuccess() throws {
        let interactor = PokemonInteractor(repository: PokemonRepositoryMock(type: .success))
        var moveFinal: MoveModel = .init()
        
        interactor.move(id: "1") { move in
            moveFinal = move
        } failure: { error in
            
        }
        XCTAssertEqual(moveFinal, MoveModel.mock)
    }
    
    func testLoadMoveInRepositoryFailure() throws {
        let interactor = PokemonInteractor(repository: PokemonRepositoryMock(type: .failure))
        var errorfinal: String = ""
        interactor.move(id: "1") { move in
        } failure: { error in
            errorfinal = "Error"
        }
        XCTAssertEqual(errorfinal, "Error")
    }

}
