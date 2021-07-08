//
//  GenerationClient.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import Foundation

import ComposableArchitecture
import Foundation

struct GenerationClient {
    var generation: (Int) -> Effect<GenerationModel, ErrorMessage>
}

// MARK: - LIVE
extension GenerationClient {
    static var live = GenerationClient(
        generation: { generation in
            return PokeAPI.send(Endpoint.generation(generation))
        }
    )
}

#if DEBUG
// MARK: - MOCK
extension GenerationClient {
    static let mock = GenerationClient (
        generation: { _ in Effect(value: .mock) }
    )
    
    static func mock(
        generation: @escaping (Int) -> Effect<GenerationModel, ErrorMessage> = { _ in fatalError()}
    ) -> GenerationClient {
        GenerationClient(generation: generation)
    }
}
#endif
