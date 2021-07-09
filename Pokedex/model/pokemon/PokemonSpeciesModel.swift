//
//  PokemonSpeciesModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import Foundation

enum GenderType {
    case male
    case female
    case both
    case genderless
}

struct PokemonSpeciesModel: Codable, Equatable {
    var id: Int = .zero
    var isBaby: Bool = false
    var isLegendary: Bool = false
    var isMythical: Bool = false
    var genderRate: Int = -1
    
    enum CodingKeys: String, CodingKey {
        case id
        case isBaby = "is_baby"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
        case genderRate = "gender_rate"
    }
}

extension PokemonSpeciesModel {
    func getGender() -> GenderType {
        switch self.genderRate {
        case -1:
            return .genderless
        case 0:
            return .male
        case 8:
            return .female
        default:
            return .both
        }
    }
}

//MARK:- Mock
#if DEBUG
extension PokemonSpeciesModel {
    static var mock = PokemonSpeciesModel(id: 1,
                                          isBaby: false,
                                          isLegendary: true,
                                          isMythical: true,
                                          genderRate: 4)
    
    static func mock(
        id: Int,
        isBaby: Bool,
        isLegendary: Bool,
        isMythical: Bool,
        genderRate: Int
    ) -> PokemonSpeciesModel {
        PokemonSpeciesModel(id: id,
                            isBaby: isBaby,
                            isLegendary: isLegendary,
                            isMythical: isMythical,
                            genderRate: genderRate)
    }
    
}
#endif
