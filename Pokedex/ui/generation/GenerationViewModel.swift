//
//  GenerationViewModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 19/08/21.
//

import Foundation
import Combine

class GenerationViewModel: ObservableObject {
    
    @Published var loading: Bool = true
    @Published var generation: GenerationType = .i
    @Published var pokemons: [PokemonModel] = .mock(15)
    @Published var pokemonsAux: [PokemonModel] = []
    @Published var isSearch: Bool = false {
        didSet {
            if isSearch {
                pokemonsAux = pokemons
            } else {
                pokemonsAux = []
            }
        }
    }
    @Published var query: String = "" {
        didSet {
            if query.isEmpty {
                pokemons = pokemonsAux
            } else {
                pokemons = pokemonsAux.filter({ $0.name.lowercased().contains(query.lowercased()) })
            }
        }
    }
    
    private var generationRepository: GenerationRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(generationRepository: GenerationRepositoryProtocol = GenerationRepository()) {
        self.generationRepository = generationRepository
    }
    
    public func onAppear() {
        getPokemos(id: generation.rawValue)
    }
    
    func generationChage(type: GenerationType) {
        generation = type
        loading = true
        getPokemos(id: type.rawValue)
    }
    
    private func  getPokemos(id: Int) {
        generationRepository.generation(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { [weak self] generation in
                self?.pokemons = generation.pokemon.map {
                    return PokemonModel(id: Pokemon.getId(url: $0.url),name: $0.name, url: $0.url)
                }
            }
            .store(in: &cancellables)
            loading = false

    }
    
}
