//
//  GenerationView.swift
//  Pokedex
//
//  Created by Luis Pineda on 6/07/21.
//

import SwiftUI
import ComposableArchitecture

struct GenerationView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @ObservedObject var generationVM: GenerationViewModel = GenerationViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.pBackground.ignoresSafeArea(.all)
                VStack(spacing: 0.0) {
                    if generationVM.isSearch {
                        SearchBarView(query: $generationVM.query) {
                            self.generationVM.isSearch = false
                        }
                        .transition(AnyTransition.move(edge: .top))
                        .animation(.easeIn)
                    }
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(generationVM.pokemons) { pokemon in
                                GenerationCellView(pokemon: pokemon) {
                                    //                                    viewStore.send(.setNavigationPokemon(selection: pokemon))
                                }.redacted(when: generationVM.loading, redactionType: .placeholder)
                            }
                        }
                        .padding()
                    }
                    .animation(.easeIn)
                    Rectangle().fill(Color.gray)
                        .frame(height: 1)
                    HStack {
                        ButtonTab(text: "I", isSelect: generationVM.generation == .i) {
                            generationVM.generationChage(type: .i)
                        }
                        ButtonTab(text: "II", isSelect: generationVM.generation == .ii) {
                            generationVM.generationChage(type: .ii)
                        }
                        ButtonTab(text: "III", isSelect: generationVM.generation == .iii) {
                            generationVM.generationChage(type: .iii)
                        }
                        ButtonTab(text: "IV", isSelect: generationVM.generation == .iv) {
                            generationVM.generationChage(type: .iv)                        }
                    }
                }
                //                .alertView(alert: viewStore.alert,
                //                           showAlert: viewStore.binding(
                //                            get: { $0.showAlert },
                //                            send: GenerationAction.showAlert
                //                           ))
                
                
                //                NavigationLink(
                //                    destination: IfLetStore(self.store.scope(state: \.pokemonState,
                //                                                             action: GenerationAction.pokemonActions),
                //                                            then: PokemonDetailView.init(store:)),
                //                    isActive: viewStore.binding(get: { $0.pokemonState != nil },
                //                                                send: { _ in .setNavigationPokemon(selection: nil)}),
                //                    label: {
                //                        EmptyView()
                //                    })
            }.navigationBarColor(.pBackgroundCard)
            .navigationBarTitle(Text("Pokedex"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                            self.generationVM.isSearch = true
                                        }) {
                                            Image(systemName: "magnifyingglass")
                                                .padding(8)
                                        }.disabled(false)
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
        GenerationView()
    }
}
