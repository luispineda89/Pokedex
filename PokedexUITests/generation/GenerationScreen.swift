//
//  GenerationScreen.swift
//  PokedexUITests
//
//  Created by Luis Pineda on 30/08/21.
//

import XCTest

struct GenerationScreen: Screen {
    var app: XCUIApplication
    
    private enum Identifiers {
        static let generationI = "I"
        static let generationII = "II"
        static let generationIII = "III"
        static let generationIV = "IV"
        static let search = "searchButton"
        static let searchTextField = "searchTextField"
        static let cancel = "Cancel"
    }
    
    func verifyTitle(_ title: String) -> Self {
        let title = app.staticTexts[title]
        XCTAssertTrue(title.waitForExistence(timeout: 2))
        return self
    }
    
    func verifyButton(_ text: String) -> Self {
        let button = app.buttons[text]
        XCTAssertTrue(button.waitForExistence(timeout: 5))
        return self
    }
    
    func tapGenerationI() -> Self {
        app.buttons[Identifiers.generationI].tap()
        return self
    }
    func tapGenerationII() -> Self {
        app.buttons[Identifiers.generationII].tap()
        return self
    }
    func tapGenerationIII() -> Self {
        app.buttons[Identifiers.generationIII].tap()
        return self
    }
    func tapGenerationIV() -> Self {
        app.buttons[Identifiers.generationIV].tap()
        return self
    }
    
    func tapPokemon(text: String) -> PokemonScreen {
        app.buttons[text].tap()
        return PokemonScreen(app: app)
    }
    
    func tapSearch() -> Self {
        app.buttons[Identifiers.search].tap()
        return self
    }
    
    func tapSearchCancel() -> Self {
        app.buttons[Identifiers.cancel].tap()
        return self
    }
    
    func typeSearch(_ query: String) -> Self {
        let search = app.textFields[Identifiers.searchTextField]
        search.tap()
        search.typeText(query)
        return self
    }
}
