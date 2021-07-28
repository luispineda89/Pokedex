//
//  GenerationCellView.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GenerationCellView: View {
    private let shadowOpacity: Double = 0.2
    private let shadowRadius: CGFloat = 3
    private let shadowY: CGFloat = 2
    let width: CGFloat = UIScreen.main.bounds.size.width
    
    @State var isAnimating: Bool = true
    
    var pokemon: PokemonModel
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack {
                WebImage(url: Endpoint.urlSprinteAnimated(id: pokemon.id), isAnimating: $isAnimating)
                    .placeholder(Image("pokeball-placeholder"))
                .playbackRate(0.8)
                .playbackMode(.normal)
                .scaledToFill()
                .frame(width: 50, height: 50)
                .padding()
                Text(pokemon.name.capitalized)
                    .textFont()
                    .lineLimit(1)
            }.frame(width: width * 0.22)
            .padding(8)
            .background(Color.pBackgroundCard)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(shadowOpacity),
                    radius: shadowRadius,
                    x: .zero,
                    y: shadowY)
            .onAppear {
                isAnimating = true
            }
            .onDisappear {
                isAnimating = false
            }
        }).buttonStyle(PlainButtonStyle())
    }
}

struct GenerationCellView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationCellView(pokemon: .mock) {
            
        }
    }
}
