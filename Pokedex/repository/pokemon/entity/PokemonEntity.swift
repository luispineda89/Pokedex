//
//  PokemonEntity.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import Foundation
import RealmSwift

class PokemonEntity: Object {
    static let idKey = "id"
    
    @objc dynamic var id: Int = .zero
    @objc dynamic var name: String = ""
    @objc dynamic var generation: Int = .zero
    @objc dynamic var likeDislike: Int = .zero
    
    override static func primaryKey() -> String? {
        return idKey
    }
}

