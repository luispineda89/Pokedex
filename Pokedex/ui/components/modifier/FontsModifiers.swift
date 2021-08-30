//
//  FontsModifiers.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import SwiftUI

enum DecorationType: String {
    case bold       = "Roboto-Bold"
    case italic     = "Roboto-Italic"
    case boldItalic = "Roboto-BoldItalic"
    case light      = "Roboto-Light"
    case medium     = "Roboto-Medium"
    case regular    = "Roboto-Regular"
}

enum FontSizeType: CGFloat {
    case bigTitle   = 25.0
    case title      = 20.0
    case text       = 16.0
    case mediumText = 14.0
    case smallText  = 12.0
}

struct TextFontSize: ViewModifier {
    var size: CGFloat = FontSizeType.text.rawValue
    var color: Color = Color.pPrimaryText
    var decoration: DecorationType = .regular
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        content
            .foregroundColor(color)
            .font(.custom(decoration.rawValue, size: scaledSize))
    }
}

extension View {
    func bigTitleFont(color: Color = Color.pPrimaryText,
                      decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFontSize(size: FontSizeType.bigTitle.rawValue,
                                    color: color,
                                    decoration: decoration))
    }
    
    func titleFont(color: Color = Color.pPrimaryText,
                   decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFontSize(size: FontSizeType.title.rawValue,
                                    color: color,
                                    decoration: decoration))
    }
    
    func textFont(color: Color = Color.pPrimaryText,
                  decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFontSize(size: FontSizeType.text.rawValue,
                                    color: color,
                                    decoration: decoration))
    }
    
    func mediumTextFont(color: Color = Color.pPrimaryText,
                        decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFontSize(size: FontSizeType.mediumText.rawValue,
                                    color: color,
                                    decoration: decoration))
    }
    
    func smallTextFont(color: Color = Color.pPrimaryText,
                       decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFontSize(size: FontSizeType.smallText.rawValue,
                                    color: color,
                                    decoration: decoration))
    }
    
    func textFontSize(size: CGFloat = FontSizeType.text.rawValue ,
                      color: Color = Color.pPrimaryText,
                      decoration: DecorationType = .regular) -> some View {
        self.modifier( TextFontSize(size: size,
                                    color: color,
                                    decoration: decoration))
    }
}
