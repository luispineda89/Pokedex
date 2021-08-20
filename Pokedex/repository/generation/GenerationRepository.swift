//
//  GenerationRepository.swift
//  Pokedex
//
//  Created by Luis Pineda on 19/08/21.
//

import Foundation
import Combine

protocol GenerationRepositoryProtocol {
    var network: NetworkProtocol { get }
    func generation (id: Int) -> AnyPublisher<GenerationModel, Error>
}

class GenerationRepository: GenerationRepositoryProtocol {
    var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func generation(id: Int) -> AnyPublisher<GenerationModel, Error> {
        return network.get(type: GenerationModel.self,
                           urlRequest: Endpoint.generation(id))
    }   
}
