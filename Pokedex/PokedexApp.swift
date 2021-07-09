//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Luis Pineda on 6/07/21.
//

import SwiftUI
import ComposableArchitecture

@main
struct PokedexApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            GenerationView(
                store: Store(
                    initialState: GenerationState(),
                    reducer: generationReducer,
                    environment: GenerationEnvironment()
                )
            )
        }
    }
}
