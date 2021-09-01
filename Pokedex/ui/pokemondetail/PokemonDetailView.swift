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
    
    @ObservedObject var pokemonDetailVM: PokemonDetailViewModel
    
    init(pokemonDetailVM: PokemonDetailViewModel) {
        self.pokemonDetailVM = pokemonDetailVM
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [pokemonDetailVM.state.colorBackground,
                                            pokemonDetailVM.state.type.count == 2 ? pokemonDetailVM.state.type[1].color : pokemonDetailVM.state.colorBackground]),
                startPoint: .top,
                endPoint: .bottom
            ).opacity(0.75).ignoresSafeArea(.all)
            VStack(spacing: 10.0) {
                WebImage(url: Endpoint.urlSprinteOfficial(id: pokemonDetailVM.state.pokemon.id))
                    .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                    .placeholder(Image("pokeball-placeholder")) // Placeholder Image
                    .indicator(.activity) // Activity Indicator
                    .animation(.easeInOut(duration: 0.5)) // Animation Duration
                    .transition(.fade) // Fade Transition
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: widthT * 0.6, height: widthT * 0.6)
                    .padding(.top, -150)
                Text(pokemonDetailVM.state.pokemon.name.capitalized)
                    .bigTitleFont(decoration: .bold)
                    .overlay(
                        GenderPokemonView(gender: pokemonDetailVM.state.pokemonSpecies.getGender())
                            .offset(x: 55, y: 0)
                        , alignment: .trailing)
                LinearGradient(
                    gradient: Gradient(colors: [pokemonDetailVM.state.colorBackground,
                                                pokemonDetailVM.state.type.count == 2 ? pokemonDetailVM.state.type[1].color : pokemonDetailVM.state.colorBackground]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 4, alignment: .center)
                .cornerRadius(5)
                .padding(.horizontal, 100)
                TypePokemonView(pokemonDetailVM: pokemonDetailVM)
                Divider().padding(.horizontal, 20)
                SprintesView(id: pokemonDetailVM.state.pokemon.id)
                AbilityPokemonView(pokemonDetailVM: pokemonDetailVM)
                MovePokemonView(pokemonDetailVM: pokemonDetailVM)
                Spacer()
            }.overlay(
                Text("No. \(pokemonDetailVM.state.pokemonDetail.pokedexId )")
                    .padding(8)
                , alignment: .topTrailing)
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pBackground))
            .padding(.top, 100)
            .padding()
            
            
            if pokemonDetailVM.state.isMoveShow {
                MoveDetailConfiguration.configuration(with: pokemonDetailVM.state.moveSelected,
                                                      showView: $pokemonDetailVM.state.isMoveShow)
            }
            
//            NavigationLink(
//                destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
//                isActive: pokemonDetailVM.state.isMoveShow,
//                label: {
//                    EmptyView()
//                })
            
            //                IfLetStore(self.store.scope(
            //                            state: \.moveState,
            //                            action: PokemonDetailAction.moveActions),
            //                           then: { MoveDetailView(store: $0) })
            
            
        }.onAppear(perform: {
            pokemonDetailVM.onAppear()
        })
        .onDisappear {
            //                viewStore.send(.onDisappear)
        }
        
    }
    
    struct TypePokemonView: View {
        
        @ObservedObject var pokemonDetailVM: PokemonDetailViewModel
        
        init(pokemonDetailVM: PokemonDetailViewModel) {
            self.pokemonDetailVM = pokemonDetailVM
        }
        
        var body: some View {
            HStack {
                VStack {
                    Text("\(pokemonDetailVM.state.pokemonDetail.weight) g")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("WEIGHT")
                        .font(.footnote)
                }
                
                if !pokemonDetailVM.state.type.isEmpty {
                    VStack(spacing: 0.0) {
                        HStack {
                            Spacer()
                            pokemonDetailVM.state.type[0].icon
                                .resizable()
                                .frame(width: 30, height: 30)
                            if pokemonDetailVM.state.type.count == 2 {
                                pokemonDetailVM.state.type[1].icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Spacer()
                            } else {
                                Spacer()
                            }
                        }
                        HStack {
                            Spacer()
                            Text(pokemonDetailVM.state.type[0].rawValue.uppercased())
                                .font(.footnote)
                                .lineLimit(1)
                            if pokemonDetailVM.state.type.count == 2 {
                                Text("/")
                                    .font(.footnote)
                                Text(pokemonDetailVM.state.type[1].rawValue.uppercased())
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
                    Text("\(pokemonDetailVM.state.pokemonDetail.height) ft")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("HEIGHT")
                        .font(.footnote)
                }
            }.padding(.horizontal, 30)
        }
    }
    
    struct AbilityPokemonView: View {
        
        @ObservedObject var pokemonDetailVM: PokemonDetailViewModel
        
        init(pokemonDetailVM: PokemonDetailViewModel) {
            self.pokemonDetailVM = pokemonDetailVM
        }
        
        var body: some View {
            VStack {
                HStack {
                    Text("Abilities:")
                    
                    ScrollView(.horizontal) {
                        LazyHStack(alignment: .top, spacing: 10) {
                            ForEach(.zero..<pokemonDetailVM.state.pokemonDetail.abilities.count, id: \.self) { index in
                                Text(pokemonDetailVM.state.pokemonDetail.abilities[index].ability.name)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 15)
                                    .background(Color.pBackgroundCard)
                                    .cornerRadius(5)
                            }
                        }.padding(.bottom, 10)
                    }.fixedSize(horizontal: false, vertical: true)
                    .accessibilityIdentifier("SVAbilities")
                }
            }.padding(.horizontal, 30)
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
    
   private struct MovePokemonView: View {
        
        @ObservedObject var pokemonDetailVM: PokemonDetailViewModel
        
        init(pokemonDetailVM: PokemonDetailViewModel) {
            self.pokemonDetailVM = pokemonDetailVM
        }
        
        var body: some View {
            VStack {
                Text("Moves")
                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(.zero..<pokemonDetailVM.state.pokemonDetail.moves.count, id: \.self) { index in
                            MoveCellView(move: pokemonDetailVM.state.pokemonDetail.moves[index]) {
                                //                                    viewStore.send(.setNavigationMove(viewStore.pokemonDetail.moves[index]))
                                pokemonDetailVM.state.moveSelected = pokemonDetailVM.state.pokemonDetail.moves[index]
                                pokemonDetailVM.state.isMoveShow = true
                            }
                        }
                    }.padding(.bottom, 10)
                    .padding(.horizontal)
                }.accessibilityIdentifier("SVMoves")
            }.padding(.horizontal)
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
        PokemonDetailView(pokemonDetailVM: PokemonDetailViewModel(state: PokemonDetailState(pokemon: .mock)))
    }
}

