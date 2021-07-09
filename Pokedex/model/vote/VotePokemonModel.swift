//
//  VotePokemonModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import Foundation
import SwiftUI

enum LikeDislike: Int {
    case like = 1
    case dislike, none
    
    var icon: String {
        switch self {
        case .like:
            return "heart.fill"
        case .dislike:
            return "xmark"
        case .none:
            return ""
        }
    }
    
    var color: Color {
        switch self {

        case .like:
            return Color.pFourth
        case .dislike:
            return Color.pThird
        case .none:
            return Color.clear
        }
    }
}

struct VotePokemonModel: Identifiable, Hashable {
    var id: Int
    var name: String
    var generation: GenerationType
    var likeDislike: LikeDislike
    
    func toEntity() -> PokemonEntity {
       let entity = PokemonEntity()
        entity.id = id
        entity.name = name
        entity.generation = generation.rawValue
        entity.likeDislike = likeDislike.rawValue
        return entity
    }
    
    static func toModel(entity: PokemonEntity) -> VotePokemonModel {
        VotePokemonModel(id: entity.id,
                         name: entity.name,
                         generation: GenerationType(rawValue: entity.generation) ?? .i,
                         likeDislike: LikeDislike(rawValue: entity.likeDislike) ?? .none)
    }
    
    static func toModels(entities: [PokemonEntity]) -> [VotePokemonModel] {
        return entities.compactMap {
            toModel(entity: $0)
        }
    }
    
}

//MARK:- Mock
#if DEBUG
extension VotePokemonModel {
    static var mock = VotePokemonModel(id: 1,
                                   name: "bulbasaur",
                                   generation: .i,
                                   likeDislike: .like)
    
    func mock(id: Int,
              name: String,
              url: String,
              generation: GenerationType,
              likeDislike: LikeDislike) -> VotePokemonModel {
        VotePokemonModel(id: id,
                         name: name,
                         generation: generation,
                         likeDislike: likeDislike)
    }
    
}
extension Array where Element == VotePokemonModel {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            VotePokemonModel(id: $0,
                         name: "pokemon \($0)",
                         generation: .i,
                         likeDislike: .like)
        }
    }
}
#endif

