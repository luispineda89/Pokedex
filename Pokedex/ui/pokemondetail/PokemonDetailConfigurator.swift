//
//  PokemonDetailConfigurator.swift
//  Pokedex
//
//  Created by Luis Pineda on 20/08/21.
//

import Foundation

final class PokemonDetailConfigurator {
    public static func configurePokemonDetailView(with pokemon: PokemonModel) -> PokemonDetailView {
        let pokemonDetailView = PokemonDetailView(pokemonDetailVM: PokemonDetailViewModel(state: PokemonDetailState(pokemon: pokemon)))
        return pokemonDetailView
    }
}
