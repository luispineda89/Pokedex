//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import SwiftUI
import SDWebImageSwiftUI
import ComposableArchitecture

struct PokemonDetailView: View {
    private let widthT: CGFloat = UIScreen.main.bounds.size.width
    let store: Store<PokemonDetailState, PokemonDetailAction>
    
    init(store: Store<PokemonDetailState, PokemonDetailAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [viewStore.colorBackground,
                                                viewStore.type.count == 2 ? viewStore.type[1].color : viewStore.colorBackground]),
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.75).ignoresSafeArea(.all)
                VStack(spacing: 10.0) {
                    WebImage(url: Endpoint.urlSprinteOfficial(id: viewStore.pokemon.id))
                        .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                        .placeholder(Image("pokeball-placeholder")) // Placeholder Image
                        .indicator(.activity) // Activity Indicator
                        .animation(.easeInOut(duration: 0.5)) // Animation Duration
                        .transition(.fade) // Fade Transition
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: widthT * 0.6, height: widthT * 0.6)
                        .padding(.top, -150)
                    Text(viewStore.pokemon.name.capitalized)
                        .bigTitleFont()
                        .overlay(
                            GenderPokemonView(gender: viewStore.pokemonSpecies.getGender())
                                .offset(x: 55, y: 0)
                            , alignment: .trailing)
                    LinearGradient(
                        gradient: Gradient(colors: [viewStore.colorBackground,
                                                    viewStore.type.count == 2 ? viewStore.type[1].color : viewStore.colorBackground]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(height: 4, alignment: .center)
                    .cornerRadius(5)
                    .padding(.horizontal, 100)
                    TypePokemonView(store: store)
                    Divider().padding(.horizontal, 20)
                    SprintesView(id: viewStore.pokemon.id)
                    AbilityPokemonView(store: store)
                    
                    MovePokemonView(store: store)
                    Spacer()
                }.overlay(
                    Text("No. \(viewStore.pokemonDetail.pokedexId )")
                        .padding(8)
                    , alignment: .topTrailing)
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.pBackground))
                .padding(.top, 100)
                .padding()
                
                IfLetStore(self.store.scope(
                            state: \.moveState,
                            action: PokemonDetailAction.moveActions),
                           then: { MoveDetailView(store: $0) })
 
            }.onAppear(perform: {
                viewStore.send(.load)
            })
            .onDisappear {
                viewStore.send(.onDisappear)
            }
        }
    }
    
    struct TypePokemonView: View {
        
        let store: Store<PokemonDetailState, PokemonDetailAction>
        
        init(store: Store<PokemonDetailState, PokemonDetailAction>) {
            self.store = store
        }
        
        var body: some View {
            WithViewStore(store) { viewStore in
                HStack {
                    VStack {
                        Text("\(viewStore.pokemonDetail.weight) g")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("WEIGHT")
                            .font(.footnote)
                    }
                    
                    if !viewStore.type.isEmpty {
                        VStack(spacing: 0.0) {
                            HStack {
                                Spacer()
                                viewStore.type[0].icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                if viewStore.type.count == 2 {
                                    viewStore.type[1].icon
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                } else {
                                    Spacer()
                                }
                            }
                            HStack {
                                Spacer()
                                Text(viewStore.type[0].rawValue.uppercased())
                                    .font(.footnote)
                                    .lineLimit(1)
                                if viewStore.type.count == 2 {
                                    Text("/")
                                        .font(.footnote)
                                    Text(viewStore.type[1].rawValue.uppercased())
                                        .font(.footnote)
                                        .lineLimit(1)
                                    Spacer()
                                } else {
                                    Spacer()
                                }
                            }
                        }
                    } else {
                        Spacer()
                    }
                    
                    VStack {
                        Text("\(viewStore.pokemonDetail.height) ft")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("HEIGHT")
                            .font(.footnote)
                    }
                }.padding(.horizontal, 30)
            }
        }
    }
    
    struct AbilityPokemonView: View {
        
        let store: Store<PokemonDetailState, PokemonDetailAction>
        
        init(store: Store<PokemonDetailState, PokemonDetailAction>) {
            self.store = store
        }
        
        var body: some View {
            WithViewStore(store) { viewStore in
                VStack {
                    HStack {
                        Text("Abilities:")
                        
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .top, spacing: 10) {
                                ForEach(.zero..<viewStore.pokemonDetail.abilities.count, id: \.self) { index in
                                    Text(viewStore.pokemonDetail.abilities[index].ability.name)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 15)
                                        .background(Color.pBackgroundCard)
                                        .cornerRadius(5)
                                }
                            }.padding(.bottom, 10)
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                }.padding(.horizontal, 30)
            }
        }
    }
    
    struct GenderPokemonView: View {
        
        var gender: GenderType = .male
        
        var body: some View {
            Group {
                switch gender {
                case .genderless:
                    EmptyView()
                case .male:
                     Image("singmale")
                        .resizable()
                        .frame(width: 30, height: 30)
                case .female:
                     Image("singfemale")
                        .resizable()
                        .frame(width: 30, height: 30)
                default:
                    Image("singmalefemale")
                        .resizable()
                        .frame(width: 48, height: 30)
                
                }
            }
        }
    }
    
    struct MovePokemonView: View {
        
        let store: Store<PokemonDetailState, PokemonDetailAction>
        
        init(store: Store<PokemonDetailState, PokemonDetailAction>) {
            self.store = store
        }
        
        var body: some View {
            WithViewStore(store) { viewStore in
                VStack {
                    Text("Moves")
                    ScrollView(.vertical) {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(.zero..<viewStore.pokemonDetail.moves.count, id: \.self) { index in
                                MoveCellView(move: viewStore.pokemonDetail.moves[index]) {
                                    viewStore.send(.setNavigationMove(viewStore.pokemonDetail.moves[index]))
                                }
                            }
                        }.padding(.bottom, 10)
                        .padding(.horizontal)
                    }
                }.padding(.horizontal)
            }
        }
    }
    
    struct SprintesView: View {
        
        var id: Int
        
        var body: some View {
            HStack {
                ImageStrinteView(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/emerald/\(id).png")
                ImageStrinteView(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/\(id).png")
                ImageStrinteView(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/\(id).png")
            }.padding(.horizontal, 30)
        }
    }
    
    struct ImageStrinteView: View {
        
        var url: String
        
        var body: some View {
            WebImage(url: URL(string: url) )
                .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                .placeholder(Image("pokeball-placeholder")) // Placeholder Image
                .indicator(.activity) // Activity Indicator
                .animation(.easeInOut(duration: 0.5)) // Animation Duration
                .transition(.fade) // Fade Transition
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 60, height: 60)
        }
    }
    
}


struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(
            store: Store(
                initialState: PokemonDetailState(pokemon: .mock,
                                                 pokemonSpecies: .mock,
                                                 pokemonDetail: .mock),
                reducer: pokemonDetailReducer,
                environment: PokemonDetailEnvironment()
            )
        )
    }
}

