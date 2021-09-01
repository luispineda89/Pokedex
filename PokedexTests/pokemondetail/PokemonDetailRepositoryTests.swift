//
//  PokemonDetailRepositoryTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import XCTest
@testable import Pokedex

class PokemonDetailRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadPokemonInRepositorySuccess() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = PokemonRepository(service: PokemonServiceMock(pokemonDetail: PokemonDetailModel.mock,
                                                                       pokemonSpecies: nil,
                                                                       move: nil))
        var pokemonFinal: PokemonDetailModel = .init()
        
        repository.pokemon(id: 1) { pokemon in
            pokemonFinal = pokemon
            exp.fulfill()
        } failure: { error in
            
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(pokemonFinal, PokemonDetailModel.mock)
    }
    
    func testLoadPokemonInRepositoryFailure() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = PokemonRepository(service: PokemonServiceMock(pokemonDetail: nil,
                                                                       pokemonSpecies: nil,
                                                                       move: nil))
        var errorfinal: String = ""
        repository.pokemon(id: 1) { pokemon in
        } failure: { error in
            errorfinal = "Error"
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(errorfinal, "Error")
    }
    
    func testLoadpokemonSpeciesInRepositorySuccess() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = PokemonRepository(service: PokemonServiceMock(pokemonDetail: nil,
                                                                       pokemonSpecies: PokemonSpeciesModel.mock,
                                                                       move: nil))
        var pokemonFinal: PokemonSpeciesModel = .init()
        
        repository.pokemonSpecies(url: "") { pokemon in
            pokemonFinal = pokemon
            exp.fulfill()
        } failure: { error in
            
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(pokemonFinal, PokemonSpeciesModel.mock)
    }
    
    func testLoadpokemonSpeciesInRepositoryFailure() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = PokemonRepository(service: PokemonServiceMock(pokemonDetail: nil,
                                                                       pokemonSpecies: nil,
                                                                       move: nil))
        var errorfinal: String = ""
        repository.pokemonSpecies(url: "") { pokemon in
        } failure: { error in
            errorfinal = "Error"
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(errorfinal, "Error")
    }

}
