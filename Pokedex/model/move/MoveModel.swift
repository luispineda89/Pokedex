//
//  MoveModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import Foundation

struct MoveModel: Identifiable, Codable, Equatable {
    var id: Int = .zero
    var accuracy: Int? = .zero
    var name: String = ""
    var power: Int? = .zero
    var pp: Int = .zero
    var priority: Int = .zero
    var type: Detail = .init()
    var effectEntries: [EffectEntry] = []
    
    struct EffectEntry: Codable, Equatable {
        var effect: String = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case accuracy
        case name
        case power
        case pp
        case priority
        case type
        case effectEntries = "effect_entries"
    }
    
    func getType() -> PokemonType {
        return PokemonType(rawValue: self.type.name) ?? .normal
    }
    
}

//MARK:- Mock
#if DEBUG
extension MoveModel {
    static var mock = MoveModel(id: 1,
                                accuracy: 1,
                                name: "move1",
                                power: 23,
                                pp: 23,
                                priority: 1,
                                type: Detail(name: "normal", url: "url.move/1"),
                                effectEntries: [EffectEntry(effect: "Lowers the target's Speed by one stage.")])
    
    func mock(
        id: Int = .zero,
        accuracy: Int? = .zero,
        name: String = "",
        power: Int? = .zero,
        pp: Int = .zero,
        priority: Int = .zero,
        type: Detail = .init(),
        effectEntries: [EffectEntry] = []
    ) -> MoveModel {
        MoveModel(id: id,
                  accuracy: accuracy,
                  name: name,
                  power: power,
                  pp: pp,
                  priority: priority,
                  type: type,
                  effectEntries: effectEntries)
    }
    
}
#endif

