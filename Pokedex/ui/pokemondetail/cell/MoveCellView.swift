//
//  MoveCellView.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import SwiftUI

struct MoveCellView: View {
    private let shadowOpacity: Double = 0.2
    private let shadowRadius: CGFloat = 3
    private let shadowY: CGFloat = 2
    
    var move: PokemonMoveModel
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(spacing: 15.0) {
                Text(move.move.getId())
                    .textFont()
                Text(move.move.name)
                    .textFont()
            Spacer()
            }.padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color.pBackgroundCard)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(shadowOpacity),
                    radius: shadowRadius,
                    x: .zero,
                    y: shadowY)
        })

    }
}

struct MoveCellView_Previews: PreviewProvider {
    static var previews: some View {
        MoveCellView(move: .mock) {
            
        }
    }
}

