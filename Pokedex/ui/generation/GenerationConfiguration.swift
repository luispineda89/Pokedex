//
//  GenerationConfiguration.swift
//  Pokedex
//
//  Created by Luis Pineda on 25/08/21.
//

import Foundation

class GenerationConfiguration {
    public static func configuration() -> GenerationView {
        let generationView = GenerationView(generationVM: GenerationViewModel())
        return generationView
    }
}
