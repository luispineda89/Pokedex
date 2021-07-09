//
//  PokemonType.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import Foundation
import SwiftUI

enum PokemonType: String {
    case bug = "bug"
    case dark = "dark"
    case dragon = "dragon"
    case electric = "electric"
    case fairy = "fairy"
    case fighting = "fighting"
    case fire = "fire"
    case flying = "flying"
    case ghost = "ghost"
    case grass = "grass"
    case ground = "ground"
    case ice = "ice"
    case normal = "normal"
    case poison = "poison"
    case psychic = "psychic"
    case rock = "rock"
    case steel = "steel"
    case water = "water"
    
    var color: Color {
        switch self {
        case .bug:
            return Color("Bug")
        case .dark:
            return Color("Dark")
        case .dragon:
            return Color("Dragon")
        case .electric:
            return Color("Electric")
        case .fairy:
            return Color("Fairy")
        case .fighting:
            return Color("Fighting")
        case .fire:
            return Color("Fire")
        case .flying:
            return Color("Flying")
        case .ghost:
            return Color("Ghost")
        case .grass:
            return Color("Grass")
        case .ground:
            return Color("Ground")
        case .ice:
            return Color("Ice")
        case .normal:
            return Color("Normal")
        case .poison:
            return Color("Poison")
        case .psychic:
            return Color("Psychic")
        case .rock:
            return Color("Rock")
        case .steel:
            return Color("Steel")
        case .water:
            return Color("Water")
        }
    }
    
    var icon: Image {
        switch self {
        case .bug:
            return Image("Bug")
        case .dark:
            return Image("Dark")
        case .dragon:
            return Image("Dragon")
        case .electric:
            return Image("Electric")
        case .fairy:
            return Image("Fairy")
        case .fighting:
            return Image("Fighting")
        case .fire:
            return Image("Fire")
        case .flying:
            return Image("Flying")
        case .ghost:
            return Image("Ghost")
        case .grass:
            return Image("Grass")
        case .ground:
            return Image("Ground")
        case .ice:
            return Image("Ice")
        case .normal:
            return Image("Normal")
        case .poison:
            return Image("Poison")
        case .psychic:
            return Image("Psychic")
        case .rock:
            return Image("Rock")
        case .steel:
            return Image("Steel")
        case .water:
            return Image("Water")
        }
    }
}
