//
//  PokemonUITests.swift
//  PokedexUITests
//
//  Created by Luis Pineda on 31/08/21.
//

import XCTest

class PokemonUITests: UITestCase {

    func testPokemon() throws {
        GenerationScreen(app: app)
            .verifyButton("I")
            .tapPokemon(text: "Bulbasaur")
            .verifyText("Bulbasaur")
            .verifyText("69 g")
            .verifyText("7 ft")
            .verifyScrollViewAbilities()
            .verifyScrollViewMove()
            .verifyButton("77, poison-powder")
    }

}
