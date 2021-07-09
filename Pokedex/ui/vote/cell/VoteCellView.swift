//
//  VoteCellView.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct VoteCellView: View {
    private let shadowOpacity: Double = 0.2
    private let shadowRadius: CGFloat = 3
    private let shadowY: CGFloat = 2
    let width: CGFloat = UIScreen.main.bounds.size.width
    
    var pokemon: VotePokemonModel

    var body: some View {
        VStack {
            WebImage(url: Endpoint.urlSprinteAnimated(id: pokemon.id), isAnimating: .constant(true))
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
        .overlay(
            Image(systemName: pokemon.likeDislike.icon)
                .textFont(color: pokemon.likeDislike.color,
                          decoration: .bold)
                .padding(5)
            , alignment: .topTrailing)
        .overlay(
            Text(pokemon.generation.text)
                .textFont(decoration: .bold)
                .padding(5)
            , alignment: .topLeading)
    }
}

struct VoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        VoteCellView(pokemon: .mock)
    }
}

