//
//  ButtonsView.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import SwiftUI

struct ButtonSecondary: View {
    let padding: CGFloat = 8
    let cornerRadius: CGFloat = 8
    
    var text: String
    var color: Color = Color.pPrimary
    var colorBackground = Color.pBackground
    var decoration: DecorationType = .bold
    var border: CGFloat = 2
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Spacer()
                Text(text)
                    .lineLimit(1)
                    .textFont(color: color,
                              decoration: decoration)
                Spacer()
            }.padding(.vertical, padding)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(color, lineWidth: border))
            .background(colorBackground)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct ButtonPrimary: View {
    let padding: CGFloat = 8
    let cornerRadius: CGFloat = 8
    
    var text: String
    var textColor: Color = Color.pSecondaryText
    var decoration: DecorationType = .bold
    var color: Color = Color.pPrimary
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack(spacing: 10) {
                Spacer()
                Text(text)
                    .lineLimit(1)
                    .textFont(color: textColor,
                              decoration: .bold)
                Spacer()
            }.padding(.vertical, padding)
            .background(color)
            .cornerRadius(cornerRadius)
        }.buttonStyle(PlainButtonStyle())
    }
}

