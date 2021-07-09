//
//  MoveDetailView.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import SwiftUI
import ComposableArchitecture

struct MoveDetailView: View {
    let padding: CGFloat = 20
    let store: Store<MoveDetailState, MoveDetailAction>
    
    @State var isOpacity: Bool = false
    @State var animation = false
    
    init(store: Store<MoveDetailState, MoveDetailAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                if self.$isOpacity.wrappedValue {
                    Color.pBackground.colorInvert().opacity(0.2)
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(10)
                        .animation(.default)
                }
                VStack(spacing: .zero) {
                    VStack(spacing: .zero) {
                        viewStore.move.getType().icon
                            .resizable()
                            .frame(width: 50, height: 50)
                            .textFontSize(size:  40,
                                          color: Color.pSecondaryText,
                                          decoration: .bold)
                            .scaleEffect(animation ? 0.8 : 0.2)
                            .rotationEffect(animation ? .degrees(360) : .degrees(0))
                            .animation(Animation.easeIn(duration: 0.5))
                            .frame(width: 80, height: 80)
                            .background(viewStore.move.getType().color)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.pBackground,
                                                lineWidth: 5))
                            .offset(y: -padding)
                            .padding(.top, -padding)
                            .onAppear {
                                self.animation = true
                                //                            withAnimation {
                                self.isOpacity = true
                                //                            }
                            }
                        VStack( spacing: padding) {
                            Text(viewStore.move.name)
                                .multilineTextAlignment(.center)
                                .titleFont(decoration: .medium)
                            
                            HStack {
                                Text("Pow: \(viewStore.move.power ?? 0)")
                                    .textFont()
                                Spacer()
                                Text("Acu: \(viewStore.move.accuracy ?? 0)")
                                    .textFont()
                                
                                Spacer()
                                Text("PP: \(viewStore.move.pp)")
                                    .textFont()
                                
                            }
                            Divider()
                            ScrollView {
                                Text(viewStore.move.effectEntries[0].effect)
                                    .titleFont()
                            }
                            .frame(minHeight: 30, maxHeight: 150)
                            .fixedSize(horizontal: false, vertical: true)
                            
                            ButtonSecondary(text: "close", color: viewStore.move.getType().color) {
                                viewStore.send(.close)
                            }
                            
                        }.padding([.horizontal, .bottom], 25)
                    }.redacted(when: viewStore.loading, redactionType: .placeholder)
                    
                }.background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.pBackground)
                                .shadow(color: Color.pPrimaryText.opacity(0.2),
                                        radius: 3,
                                        x: .zero,
                                        y: 2))
                
                .padding(.horizontal, 30)
                .zIndex(15)
                
            }
            
            .onAppear(perform: {
                viewStore.send(.load)
            })
        }
    }
}

struct MoveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoveDetailView(
            store: Store(
                initialState: MoveDetailState(pokemonMove: .mock),
                reducer: moveDetailReducer,
                environment: MoveDetailEnvironment(pokemonClient: .mock)
            )
        )
    }
}

