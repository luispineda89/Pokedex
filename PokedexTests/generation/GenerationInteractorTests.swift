//
//  GenerationInteractorTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import XCTest
@testable import Pokedex

class GenerationInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadGenerationInRepositorySuccess() throws {
        let interactor = GenerationInteractor(repository: GenerationRepositoryMock(type: .success))
        var pokemons2: [PokemonModel] = []
        
        interactor.generation(id: 1) { pokemons in
            pokemons2 = pokemons
        } failure: { error in
            print(error)
        }
        XCTAssertGreaterThanOrEqual(pokemons2.count, 2)
    }
    
    func testLoadGenerationInRepositoryFailure() throws {
        let interactor = GenerationInteractor(repository: GenerationRepositoryMock(type: .failure))
        var errorfinal: String = ""
        interactor.generation(id: 1) { pokemons in
            print("\(pokemons.count)")
        } failure: { error in
            print(error)
            errorfinal = "Error"
        }
        XCTAssertEqual(errorfinal, "Error")
    }

}
