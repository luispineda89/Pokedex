//
//  GenerationService.swift
//  Pokedex
//
//  Created by Luis Pineda on 19/08/21.
//

import Foundation
import Combine

protocol GenerationServiceProtocol {
    func generation (id: Int) -> AnyPublisher<GenerationModel, Error>
}

class GenerationService: GenerationServiceProtocol {
    private var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func generation(id: Int) -> AnyPublisher<GenerationModel, Error> {
        return network.get(type: GenerationModel.self,
                           urlRequest: Endpoint.generation(id))
    }   
}
