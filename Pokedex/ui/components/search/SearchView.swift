//
//  SearchView.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import Foundation
import SwiftUI
import ComposableArchitecture

public struct SearchBarView: View {
    
    let store: Store<SearchState, SearchAction>
    
    public init(store: Store<SearchState, SearchAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search Pokemon",
                              text: viewStore.binding(
                                get: \.query,
                                send: SearchAction.queryChanged
                              ))
                    Button(action: { viewStore.send(.queryChanged("")) }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color.gray)
                    }

                }.padding(8)
                .background(RoundedRectangle(cornerRadius: 15.0)
                                .fill(Color.pBackgroundTF))
                Button(action: { viewStore.send(.cancel) }) {
                    Text("Cancel")
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(
            store: Store(
                initialState: SearchState(),
                reducer: searchReducer,
                environment: SearchEnvironment()
            )
        )
    }
}
