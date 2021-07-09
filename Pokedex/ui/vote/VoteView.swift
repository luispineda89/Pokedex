//
//  VoteView.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import SwiftUI
import SDWebImageSwiftUI
import ComposableArchitecture

struct VoteView: View {
    
    let store: Store<VoteState, VoteAction>
    
    init(store: Store<VoteState, VoteAction>) {
        self.store = store
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    func getWidth(count: Int,
                  id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(count - 1 - id) * 10
        return UIScreen.main.bounds.size.width - offset - 30
    }
    
    func getOffset(count: Int,
                   id: Int) -> CGFloat {
        return  CGFloat(count - 1 - id) * 10
    }
    
    var body: some View {
        
        WithViewStore(store) { viewStore in
            ZStack {
                Color.pBackground.ignoresSafeArea(.all)
                VStack {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewStore.pokemonLocals) { pokemon in
                                VoteCellView(pokemon: pokemon)
                            }
                        }.padding()
                    }.animation(.easeIn)
                }.alertView(alert: viewStore.alert,
                            showAlert: viewStore.binding(
                                get: { $0.showAlert },
                                send: VoteAction.showAlert
                            ))
                VStack {
                    ZStack {
                        if !viewStore.pokeDetails.isEmpty {
                            ForEach(.zero..<(viewStore.pokeDetails.count), id: \.self) { index in
                                VoteCardView(pokemon: viewStore.pokeDetails[index]) { likeDislike, pokemon in
                                    viewStore.send(.save(pokemon, likeDislike))
                                }
                                .disabled(index + 1 != viewStore.pokeDetails.count)
                                .animation(.spring())
                                .frame(width: getWidth(count: viewStore.pokeDetails.count,
                                                       id: index),
                                       height: 500)
                                .offset(x: .zero,
                                        y: getOffset(count: viewStore.pokeDetails.count,
                                                     id: index))
                                .redacted(when: viewStore.loading, redactionType: .placeholder)
                            }.disabled(viewStore.loading)
                        }
                    }
                }.padding(15)
            }.onAppear {
                viewStore.send(.load)
            }
            .navigationBarColor(.pBackgroundCard)
            .navigationBarTitle(Text("Vote"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        viewStore.send(.details)
                                    }) {
                                        Image(systemName: "heart.fill")
                                            .padding(8)
                                    }
            )
        }
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView(
            store: Store(
                initialState: VoteState(generation: .i,
                                        pokemonsGeneration: .mock(100),
                                        pokemonLocals: .mock(6)),
                reducer: voteReducer,
                environment: VoteEnvironment()
            )
        )
    }
}
