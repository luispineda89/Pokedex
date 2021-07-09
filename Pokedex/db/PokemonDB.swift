//
//  PokemonDB.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import RealmSwift

class PokemonDB {
    static let shared = PokemonDB()
    
    private let byId = "SELF.id == %d"
    
    private lazy var realm: Realm = {
        return try! Realm()
    }()
    
    func get() -> [PokemonEntity] {
        let pokemon = realm.objects(PokemonEntity.self)
        return Array(pokemon)
    }
    
    func save(pokemon: PokemonEntity) {
        try! realm.write {
            realm.add(pokemon)
        }
    }
}

