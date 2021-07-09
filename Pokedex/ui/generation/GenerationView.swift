//
//  GenerationView.swift
//  Pokedex
//
//  Created by Luis Pineda on 6/07/21.
//

import SwiftUI
import ComposableArchitecture

struct GenerationView: View {
    
    let store: Store<GenerationState, GenerationAction>
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    init(store: Store<GenerationState, GenerationAction>) {
        self.store = store
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.pBackgroundCard
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ZStack {
                    Color.pBackground.ignoresSafeArea(.all)
                    VStack(spacing: 0.0) {
                        IfLetStore(
                            self.store.scope(
                                state: \.search,
                                action: GenerationAction.search
                            ),
                            then: SearchBarView.init(store:)
                        )
                        .transition(AnyTransition.move(edge: .top))
                        .animation(.easeIn)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 15)
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(viewStore.pokemons) { pokemon in
                                    GenerationCellView(pokemon: pokemon) {
                                        viewStore.send(.setNavigationPokemon(selection: pokemon))
                                    }.redacted(when: viewStore.loading, redactionType: .placeholder)
                                }
                            }
                            .padding()
                        }
                        .animation(.easeIn)
                        Rectangle().fill(Color.gray)
                            .frame(height: 1)
                        HStack {
                            ButtonTab(text: "I", isSelect: viewStore.generation == .i) {
                                viewStore.send(.generationChage(.i))
                            }
                            ButtonTab(text: "II", isSelect: viewStore.generation == .ii) {
                                viewStore.send(.generationChage(.ii))
                            }
                            ButtonTab(text: "III", isSelect: viewStore.generation == .iii) {
                                viewStore.send(.generationChage(.iii))
                            }
                            ButtonTab(text: "IV", isSelect: viewStore.generation == .iv) {
                                viewStore.send(.generationChage(.iv))
                            }
                        }
                    }
                    .alertView(alert: viewStore.alert,
                               showAlert: viewStore.binding(
                                get: { $0.showAlert },
                                send: GenerationAction.showAlert
                               ))
                    NavigationLink(
                        destination: IfLetStore(self.store.scope(state: \.pokemonState,
                                                                 action: GenerationAction.pokemonActions),
                                                then: PokemonDetailView.init(store:)),
                        isActive: viewStore.binding(get: { $0.pokemonState != nil },
                                                    send: { _ in .setNavigationPokemon(selection: nil)}),
                        label: {
                            EmptyView()
                        })
                }.navigationBarColor(.pBackgroundCard)
                .navigationBarTitle(Text("Pokedex"), displayMode: .inline)
                .navigationBarItems(trailing:
                                        
                                        Button(action: { viewStore.send(.searchTapped) }) {
                                            Image(systemName: "magnifyingglass")
                                                .padding(8)
                                        }.disabled(viewStore.search != nil)
                                        .buttonStyle(PlainButtonStyle())
                )
                .onAppear(perform: {
                    viewStore.send(.load)
                })
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
        GenerationView(
            store: Store(
                initialState: GenerationState(pokemons: .mock(15)),
                reducer: generationReducer,
                environment: GenerationEnvironment()
            )
        )
    }
}
