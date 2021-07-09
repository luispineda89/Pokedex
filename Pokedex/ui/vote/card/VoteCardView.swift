//
//  VoteCardView.swift
//  Pokedex
//
//  Created by Luis Pineda on 9/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct VoteCardView: View {
    
    var pokemon: PokemonDetailModel
    var save: (LikeDislike, PokemonDetailModel) -> ()
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: LikeDislike = .none
    private let thresholdPercentage: CGFloat = 0.4
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing) {
                    WebImage(url: Endpoint.urlSprinteOfficial(id: pokemon.id))
                        .renderingMode(.original)
                        .resizable()
                        .placeholder(Image("pokeball-black"))
                        .indicator(.activity)
                        .transition(.fade)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.4)
                        .clipped()
                        .padding(.top, 10)
                    if self.swipeStatus == .like {
                        Text("LIKE")
                            .font(.headline)
                            .padding()
                            .animation(.easeIn)
                            .cornerRadius(10)
                            .foregroundColor(Color.pFourth)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.pFourth, lineWidth: 3.0)
                            ).padding(30)
                            .rotationEffect(Angle.degrees(-25))
                    } else if self.swipeStatus == .dislike {
                        Text("DISLIKE")
                            .font(.headline)
                            .padding()
                            .animation(.easeIn)
                            .cornerRadius(10)
                            .foregroundColor(Color.pThird)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.pThird, lineWidth: 3.0)
                            ).padding(.top, 45)
                            .rotationEffect(Angle.degrees(25))
                    }
                }
                VStack(spacing: 6) {
                    Text(pokemon.name)
                        .bigTitleFont(decoration: .bold)
                    LinearGradient(
                        gradient: Gradient(colors: [pokemon.getType()[0].color,
                                                    pokemon.getType().count == 2 ? pokemon.getType()[1].color : pokemon.getType()[0].color]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(height: 4, alignment: .center)
                    .cornerRadius(5)
                    .padding(.horizontal, 50)
                    
                    VStack(spacing: 0.0) {
                        HStack {
                            Spacer()
                            pokemon.getType()[0].icon
                                .resizable()
                                .frame(width: 30, height: 30)
                            if pokemon.getType().count == 2 {
                                pokemon.getType()[1].icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Spacer()
                            } else {
                                Spacer()
                            }
                        }
                        HStack {
                            Spacer()
                            Text(pokemon.getType()[0].rawValue.uppercased())
                                .font(.footnote)
                                .lineLimit(1)
                            if pokemon.getType().count == 2 {
                                Text("/")
                                    .font(.footnote)
                                Text(pokemon.getType()[1].rawValue.uppercased())
                                    .font(.footnote)
                                    .lineLimit(1)
                                Spacer()
                            } else {
                                Spacer()
                            }
                        }
                        Text("No. \(pokemon.pokedexId)")
                            .titleFont()
                            .padding(.top)
                        HStack {
                            ButtonVoteView(systemName: "xmark", color: Color.pThird) {
                                save(.dislike, pokemon)
                            }
                            Spacer()
                            ButtonVoteView(systemName: "heart.fill", color: Color.pFourth) {
                                save(.like, pokemon)
                            }
                        }.padding(.top, -60)
                        .padding([.horizontal, .bottom], 10)
                    }
                }.padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color.pBackgroundCard)
            .cornerRadius(10)
            .animation(.interactiveSpring())
            .shadow(color: Color.black.opacity(0.8),
                    radius: 6,
                    x: .zero,
                    y: .zero)
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        
                        if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            self.swipeStatus = .like
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            self.swipeStatus = .dislike
                        } else {
                            self.swipeStatus = .none
                        }
                    }.onEnded { value in
                        if abs(getGesturePercentage(geometry, from: value)) > thresholdPercentage {
                            if swipeStatus != .none {
                                save(swipeStatus, pokemon)
                            }
                        } else {
                            translation = .zero
                        }
                    }
            )
        }
    }
    
    struct ButtonVoteView: View {
        var systemName: String
        var color: Color
        var action: () -> ()
        var body: some View {
            Button(action: {
                action()
            }, label: {
                ZStack {
                    Circle()
                        .fill(Color.pBackgroundCard)
                        .frame(width: 70, height: 70)
                        .shadow(color: color.opacity(0.8),
                                radius: 6,
                                x: .zero,
                                y: .zero)
                    VStack{
                        Image(systemName: systemName)
                            .textFontSize(size: 35, color: color, decoration: .bold)
                    }
                }
            }).buttonStyle(PlainButtonStyle())
        }
    }
}

struct VoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        VoteCardView(pokemon: .mock) { _, _ in
            
        }
    }
}

