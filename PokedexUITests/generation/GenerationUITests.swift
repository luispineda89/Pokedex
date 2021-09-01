//
//  GenerationUITests.swift
//  PokedexUITests
//
//  Created by Luis Pineda on 6/07/21.
//

import XCTest

class GenerationUITests: UITestCase {
    
    func testGeneration() {
        GenerationScreen(app: app)
            .verifyTitle("Pokedex")
            .verifyButton("I")
            .verifyButton("II")
            .verifyButton("Bulbasaur")
            .tapGenerationII()
            .verifyButton("Chikorita")
            .tapGenerationIII()
            .verifyButton("Treecko")
            .tapGenerationIV()
            .verifyButton("Turtwig")
            .tapSearch()
            .typeSearch("Arceus")
            .verifyButton("Arceus")
            .tapSearchCancel()
            .verifyButton("I")
            .tapGenerationI()
            .verifyButton("Bulbasaur")
    }
}
