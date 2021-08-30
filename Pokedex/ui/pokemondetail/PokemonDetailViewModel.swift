//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 20/08/21.
//

import Foundation
import Combine
import SwiftUI

//MARK:- State
struct PokemonDetailState: Equatable {
    var pokemon: PokemonModel
    var pokemonSpecies: PokemonSpeciesModel = .init()
    var pokemonDetail: PokemonDetailModel = .init()
    var type: [PokemonType] = []
    var abilities: [AbilityModel] = []
    var colorBackground: Color = .pBackground
    var moveSelected: PokemonMoveModel = .init()
    var isMoveShow: Bool = false
    var moveState: MoveDetailState?
}

class PokemonDetailViewModel: ObservableObject {
    
    @Published var state: PokemonDetailState
    
    private var pokemonInteractor: PokemonDetailInteractorProtocol
    
    init(state: PokemonDetailState,
         pokemonInteractor: PokemonDetailInteractorProtocol = PokemonInteractor()) {
        self.state = state
        self.pokemonInteractor = pokemonInteractor
    }
    
    public func onAppear() {
        getPokemon()
        getPokemonSpecies()
    }
    
    private func getPokemon() {
        pokemonInteractor.pokemon(id: state.pokemon.id) { pokemon in
            let type: [PokemonType] = pokemon.getType()
            self.state.pokemonDetail = pokemon
            self.state.type = type
            self.state.abilities = pokemon.abilities
            self.state.colorBackground = type[0].color
        } failure: { error in
            print(error)
        }
    }
    
    func getPokemonSpecies() {
        pokemonInteractor.pokemonSpecies(url: state.pokemon.url) { pokemon in
            self.state.pokemonSpecies = pokemon
        } failure: { error in
            print(error)
        }
    }
}
