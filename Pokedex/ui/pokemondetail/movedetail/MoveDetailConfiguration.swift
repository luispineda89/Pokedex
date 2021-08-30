//
//  MoveDetailConfiguration.swift
//  Pokedex
//
//  Created by Luis Pineda on 25/08/21.
//

import Foundation
import SwiftUI

final class MoveDetailConfiguration {
    public static func configuration(with pokemonMove: PokemonMoveModel, showView: Binding<Bool>) -> MoveDetailView {
        let moveDetailView = MoveDetailView(moveDetailVM: MoveDetailViewModel(state: MoveDetailState(pokemonMove: pokemonMove)), showView: showView)
        return moveDetailView
    }
}
