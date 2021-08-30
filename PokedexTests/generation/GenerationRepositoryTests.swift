//
//  GenerationRepositoryTests.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import XCTest
@testable import Pokedex

class GenerationRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadGenerationInRepositorySuccess() throws {
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
    
    func testLoadGenerationInRepositoryFailure() throws {
        let exp = expectation(description: "expectation Loading generation")
        let repository = GenerationRepository(service: GenerationServiceMock(generation: nil))
        var errorfinal: String = ""
        repository.generation(id: 1) { pokemons in
            print("\(pokemons.count)")
        } failure: { error in
            print(error)
            errorfinal = "Error"
            exp.fulfill()
        }
        waitForExpectations(timeout: 3)
        XCTAssertEqual(errorfinal, "Error")
    }

}
