//
//  GenerationView.swift
//  Pokedex
//
//  Created by Luis Pineda on 6/07/21.
//

import SwiftUI

struct GenerationView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @ObservedObject var generationVM: GenerationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.pBackground.ignoresSafeArea(.all)
                VStack(spacing: 0.0) {
                    if generationVM.state.isSearch {
                        SearchBarView(query: $generationVM.state.query) {
                            self.generationVM.state.isSearch = false
                        }
                        .transition(AnyTransition.move(edge: .top))
                        .animation(.easeIn)
                    }
                    ListPokemons(generationVM: generationVM)
                    Rectangle().fill(Color.gray)
                        .frame(height: 1)
                    ButtonsTab(generationVM: generationVM)
                }
                .alertView(alert: generationVM.state.alert,
                           showAlert: $generationVM.state.showAlert)
                NavigationLink(
                    destination: PokemonDetailConfigurator.configurePokemonDetailView(with: generationVM.state.pokemon),
                    isActive: $generationVM.state.isSelectPokemon,
                    label: {
                        EmptyView()
                    })
            }.navigationBarColor(.pBackgroundCard)
            .navigationBarTitle(Text("Pokedex"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                            self.generationVM.state.isSearch = true
                                        }) {
                                            Image(systemName: "magnifyingglass")
                                                .padding(8)
                                        }.disabled(false)
                                        .accessibilityIdentifier("searchButton")
                                        .buttonStyle(PlainButtonStyle())
                                        
                                        //                                        NavigationLink(destination: VoteView(
                                        //                                            store: Store(
                                        //                                                initialState: VoteState(generation: viewStore.generation,
                                        //                                                                        pokemonsGeneration: viewStore.pokemons),
                                        //                                                reducer: voteReducer,
                                        //                                                environment: VoteEnvironment()
                                        //                                            )
                                        //                                        )) {
                                        //                                            Label("", systemImage: "heart.fill")
                                        //                                        }
                                    }
            )
            .onAppear(perform: {
                generationVM.onAppear()
            })
        }
    }
    
    struct ListPokemons: View {
        let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
        @ObservedObject var generationVM: GenerationViewModel
        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(generationVM.state.pokemons) { pokemon in
                        GenerationCellView(pokemon: pokemon) {
                            generationVM.state.pokemon = pokemon
                            generationVM.state.isSelectPokemon = true
                        }.redacted(when: generationVM.state.loading, redactionType: .placeholder)
                    }
                }
                .padding()
            }
            .animation(.easeIn)
        }
    }
    
    struct ButtonsTab: View {
        @ObservedObject var generationVM: GenerationViewModel
        var body: some View {
            HStack {
                ButtonTab(text: "I", isSelect: generationVM.state.generation == .i) {
                    generationVM.generationChage(type: .i)
                }
                ButtonTab(text: "II", isSelect: generationVM.state.generation == .ii) {
                    generationVM.generationChage(type: .ii)
                }
                ButtonTab(text: "III", isSelect: generationVM.state.generation == .iii) {
                    generationVM.generationChage(type: .iii)
                }
                ButtonTab(text: "IV", isSelect: generationVM.state.generation == .iv) {
                    generationVM.generationChage(type: .iv)                        }
            }
        }
    }
    
    struct ButtonTab: View {
        let text: String
        var isSelect: Bool
        var action: () -> ()
        var body: some View {
            Button(action: {
                action()
            }, label: {
                HStack {
                    Spacer()
                    Text(text)
                        .titleFont(color: isSelect ? Color.pPrimary : Color.gray)
                        .padding()
                    Spacer()
                }.background(Color.pBackground)
            })
            .overlay( Group {
                if isSelect {
                    Rectangle().fill(Color.pPrimary)
                        .frame(height: 3)
                } else {
                    EmptyView()
                }
            }
            ,alignment: .top)
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct GenerationView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationConfiguration.configuration()
    }
}
