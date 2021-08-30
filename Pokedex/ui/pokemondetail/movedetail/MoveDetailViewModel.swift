//
//  MoveDetailViewModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 20/08/21.
//

import Foundation

//MARK:- State
struct MoveDetailState: Equatable {
    var pokemonMove: PokemonMoveModel
    var move: MoveModel = .mock
    var loading: Bool = true
}

class MoveDetailViewModel: ObservableObject {
    
    @Published var state: MoveDetailState
    
    private var pokemonInteractor: PokemonMoveInteractorProtocol
    
    init(state: MoveDetailState,
         pokemonInteractor: PokemonMoveInteractorProtocol = PokemonInteractor()) {
        self.state = state
        self.pokemonInteractor = pokemonInteractor
        getMove()
    }
    
    private func getMove() {
        pokemonInteractor.move(id: state.pokemonMove.move.getId()) { move in
            self.state.move = move
            self.state.loading = false
        } failure: { error in
            print(error)
            self.state.loading = false
        }
    }
}
