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

//MARK:- Mock
#if DEBUG
class GenerationServiceMock: GenerationServiceProtocol {
    
    var generation: GenerationModel?
    
    init(generation: GenerationModel?) {
        self.generation = generation
    }
    
    func generation(id: Int) -> AnyPublisher<GenerationModel, Error> {
        guard let generationModel = generation else {
            return Result<GenerationModel, Error>.Publisher(URLError(.timedOut)).eraseToAnyPublisher()
        }
        return Result<GenerationModel, Error>.Publisher(generationModel).eraseToAnyPublisher()
    }
}
#endif
