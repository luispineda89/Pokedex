//
//  SearchCore.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import Foundation
import ComposableArchitecture

//MARK:- State
public struct SearchState: Equatable {
    public var query: String = ""
}

//MARK:- Action
public enum SearchAction: Equatable {
    case queryChanged(String)
    case cancel
}

//MARK:- Environment
public struct SearchEnvironment {}

//MARK:- Reducer
public let searchReducer = Reducer<SearchState, SearchAction, SearchEnvironment> {
    state, action, environment in
    
    switch action {
    case .queryChanged(let query):
        state.query = query
        return .none
    case .cancel:
        state.query = ""
        return .none
    }
}

