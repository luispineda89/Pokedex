//
//  PokemonScreen.swift
//  PokedexUITests
//
//  Created by Luis Pineda on 31/08/21.
//

import XCTest

struct PokemonScreen: Screen {
    var app: XCUIApplication
    
    private enum Identifiers {
        static let scrollViewAbilities = "SVAbilities"
        static let scrollViewMove = "SVMoves"
    }
    
    func verifyText(_ text: String) -> Self {
        let elementeText = app.staticTexts[text]
        XCTAssertTrue(elementeText.waitForExistence(timeout: 2))
        return self
    }
    
    func verifyButton(_ text: String) -> Self {
        let button = app.buttons[text]
        XCTAssertTrue(button.waitForExistence(timeout: 5))
        return self
    }
    
    func verifyScrollViewAbilities() -> Self {
        let scroll = app.scrollViews[Identifiers.scrollViewAbilities]
        XCTAssertTrue(scroll.waitForExistence(timeout: 5))
        return self
    }
    
    func verifyScrollViewMove() -> Self {
        let scroll = app.scrollViews[Identifiers.scrollViewMove]
        XCTAssertTrue(scroll.waitForExistence(timeout: 5))
        scroll.swipeUp()
        return self
    }
    
}
