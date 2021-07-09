//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import Foundation

struct PokemonDetailModel: Identifiable, Codable, Equatable {
    var id: Int = .zero
    var name: String = ""
    var weight: Int = .zero
    var height: Int = .zero
    var pokedexId: Int = .zero
    var types: [PokemonTypeModel] = []
    var abilities: [AbilityModel] = []
    var moves: [PokemonMoveModel] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weight
        case height
        case pokedexId = "order"
        case types
        case abilities
        case moves
    }
    
    func getType() -> [PokemonType] {
        return self.types.map {
            PokemonType(rawValue: $0.type.name) ?? .normal
        }
    }
}

//MARK:- Mock
#if DEBUG
extension PokemonDetailModel {
    static var mock = PokemonDetailModel(id: 1,
                                         name: "bulbasaur",
                                         weight: 8,
                                         height: 27,
                                         pokedexId: 1,
                                         types: .mock(2),
                                         abilities: .mock(2),
                                         moves: .mock(2))
    
    func mock(id: Int = .zero,
              name: String = "",
              weight: Int = .zero,
              height: Int = .zero,
              pokedexId: Int = .zero,
              types: [PokemonTypeModel] = [],
              abilities: [AbilityModel] = [],
              moves: [PokemonMoveModel] = []) -> PokemonDetailModel {
        PokemonDetailModel(id: id,
                           name: name,
                           weight: weight,
                           height: height,
                           pokedexId: pokedexId,
                           types: types,
                           abilities: abilities,
                           moves: moves)
    }
    
}
extension Array where Element == PokemonDetailModel {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            PokemonDetailModel(id: $0,
                               name: "pokemon \($0)",
                               weight: 8,
                               height: 27,
                               pokedexId: $0,
                               types: .mock(2),
                               abilities: .mock(2),
                               moves: .mock(2))
        }
    }
}
#endif




// MARK: - AbilityModel
struct AbilityModel: Codable , Equatable{
    var ability: Detail = .init()
}

struct Detail: Codable, Equatable{
    var name: String = ""
    var url: String = ""
    
    func getId() -> String {
        let id = URL(string: url)?.lastPathComponent ?? "0"
        return id
    }
}

//MARK: Mock
#if DEBUG
extension AbilityModel {
    static var mock = AbilityModel(ability: Detail(name: "ability1", url: "url.ability/1/"))
}

extension Array where Element == AbilityModel {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            AbilityModel(ability: Detail(name: "ability\($0)", url: "url.ability/\($0)/"))
        }
    }
}
#endif

// MARK: - PokemonTypeModel
struct PokemonTypeModel: Codable, Identifiable, Equatable {
    var id: Int = .zero
    var type: Detail = .init()
    
    enum CodingKeys: String, CodingKey {
        case id = "slot"
        case type
    }
}

//MARK: Mock
#if DEBUG
extension PokemonTypeModel {
    static var mock = PokemonTypeModel(id: 1, type: Detail(name: "Type1", url: "url.type/1/"))
    
}
extension Array where Element == PokemonTypeModel {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            PokemonTypeModel(id: $0, type: Detail(name: "grass", url: "url.type/\($0)/"))
        }
    }
}
#endif

// MARK: - PokemonMoveModel
struct PokemonMoveModel: Codable, Equatable{
    var move: Detail = .init()
    var versionDetails: [VersionDetails] = []
    
    enum CodingKeys: String, CodingKey {
        case move
        case versionDetails = "version_group_details"
    }
}

struct VersionDetails: Codable, Equatable {
    var level: Int = .zero
    var method: Detail = .init()
    var version: Detail = .init()
    
    enum CodingKeys: String, CodingKey {
        case level = "level_learned_at"
        case method = "move_learn_method"
        case version = "version_group"
    }
}

//MARK: Mock
#if DEBUG
extension PokemonMoveModel {
    static var mock = PokemonMoveModel(move: Detail(name: "move1", url: "url.move/1"),
                                       versionDetails: .mock(2))
    
}

extension VersionDetails {
    static var mock = VersionDetails(level: 1,
                                     method: Detail(name: "method1", url: "url.method/1"),
                                     version: Detail(name: "version1", url: "url.version/1"))
}

extension Array where Element == PokemonMoveModel {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            PokemonMoveModel(move: Detail(name: "move\($0)", url: "url.move/\($0)"),
                             versionDetails: .mock(2))
        }
    }
}
extension Array where Element == VersionDetails {
    static func mock(_ n: Int) -> Array {
        (1..<n+1).map {
            VersionDetails(level: $0,
                           method: Detail(name: "method\($0)", url: "url.method/\($0)"),
                           version: Detail(name: "version\($0)", url: "url.version/\($0)"))
        }
    }
}
#endif
