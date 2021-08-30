//
//  GenerationServiceMock.swift
//  PokedexTests
//
//  Created by Luis Pineda on 30/08/21.
//

import Foundation
import  Combine
@testable import Pokedex

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
