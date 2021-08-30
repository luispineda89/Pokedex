//
//  GenerationViewModel.swift
//  Pokedex
//
//  Created by Luis Pineda on 19/08/21.
//

import Foundation

enum GenerationType: Int {
    case i = 1
    case ii, iii, iv
    
    var text: String {
        switch self {
        case .i:
            return "I"
        case .ii:
            return "II"
        case .iii:
            return "III"
        case .iv:
            return "IV"
        }
    }
}

//MARK:- State
struct GenerationState: Equatable {
    var loading: Bool = false
    var generation: GenerationType = .i
    var isSelectPokemon: Bool = false
    var pokemon: PokemonModel = PokemonModel()
    var pokemons: [PokemonModel] = .mock(15)
    var pokemonsAux: [PokemonModel] = []
    var showAlert: Bool = false
    var isSearch: Bool = false {
        didSet {
            if isSearch {
                pokemonsAux = pokemons
            } else {
                query = ""
                pokemonsAux = []
            }
        }
    }
    var query: String = "" {
        didSet {
            if query.isEmpty {
                pokemons = pokemonsAux
            } else {
                pokemons = pokemonsAux.filter({ $0.name.lowercased().contains(query.lowercased()) })
            }
        }
    }
    var alert: AlertModel = AlertModel()
    
    mutating func alertError(error: String) {
        self.alert.set(id: 1,
                       title: "Error!",
                       text: "Error: \(error).!",
                       textClose: "Cerrar",
                       type: .error)
    }
}

//MARK:- ViewModel
class GenerationViewModel: ObservableObject {
    
    @Published var state: GenerationState  = GenerationState()
    
    private var generationInteractor: GenerationInteractorProtocol
    
    init(generationInteractor: GenerationInteractorProtocol = GenerationInteractor()) {
        self.generationInteractor = generationInteractor
    }
    
    public func onAppear() {
        getPokemos(id: state.generation.rawValue)
    }
    
    func generationChage(type: GenerationType) {
        state.generation = type
        getPokemos(id: type.rawValue)
    }
    
    private func getPokemos(id: Int) {
        state.loading = true
        generationInteractor.generation(id: id) { pokemons in
            self.state.pokemons = pokemons
            self.state.loading = false
        } failure: { error in
            self.state.alertError(error: error)
            self.state.showAlert = true
            self.state.loading = false
        }
    }
}
