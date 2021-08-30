//
//  MoveDetailView.swift
//  Pokedex
//
//  Created by Luis Pineda on 8/07/21.
//

import SwiftUI


struct MoveDetailView: View {
    let padding: CGFloat = 20
    
    @State var isOpacity: Bool = false
    @State var animation = false
    
    @ObservedObject var moveDetailVM: MoveDetailViewModel
    @Binding var showView: Bool
    
    init(moveDetailVM: MoveDetailViewModel,
         showView: Binding<Bool>) {
        self.moveDetailVM = moveDetailVM
        _showView = showView
    }
    
    var body: some View {
        ZStack {
            if self.$isOpacity.wrappedValue {
                Color.pBackground.colorInvert().opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(10)
                    .animation(.default)
            }
            VStack(spacing: .zero) {
                VStack(spacing: .zero) {
                    moveDetailVM.state.move.getType().icon
                        .resizable()
                        .frame(width: 50, height: 50)
                        .textFontSize(size:  40,
                                      color: Color.pSecondaryText,
                                      decoration: .bold)
                        .scaleEffect(animation ? 0.8 : 0.2)
                        .rotationEffect(animation ? .degrees(360) : .degrees(0))
                        .animation(Animation.easeIn(duration: 0.5))
                        .frame(width: 80, height: 80)
                        .background(moveDetailVM.state.move.getType().color)
                        .clipShape(Circle())
                        .overlay(Circle()
                                    .stroke(Color.pBackground,
                                            lineWidth: 5))
                        .offset(y: -padding)
                        .padding(.top, -padding)
                        .onAppear {
                            self.animation = true
                            self.isOpacity = true
                        }
                    VStack( spacing: padding) {
                        Text(moveDetailVM.state.move.name)
                            .multilineTextAlignment(.center)
                            .titleFont(decoration: .medium)
                        HStack {
                            Text("Pow: \(moveDetailVM.state.move.power ?? 0)")
                                .textFont()
                            Spacer()
                            Text("Acu: \(moveDetailVM.state.move.accuracy ?? 0)")
                                .textFont()
                            
                            Spacer()
                            Text("PP: \(moveDetailVM.state.move.pp)")
                                .textFont()
                        }
                        Divider()
                        ScrollView {
                            Text(moveDetailVM.state.move.effectEntries[0].effect)
                                .titleFont()
                        }
                        .frame(minHeight: 30, maxHeight: 150)
                        .fixedSize(horizontal: false, vertical: true)
                        ButtonSecondary(text: "close",
                                        color: moveDetailVM.state.move.getType().color) {
                            showView = false
                        }
                    }.padding([.horizontal, .bottom], 25)
                }.redacted(when: moveDetailVM.state.loading, redactionType: .placeholder)
            }.background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pBackground)
                            .shadow(color: Color.pPrimaryText.opacity(0.2),
                                    radius: 3,
                                    x: .zero,
                                    y: 2))
            
            .padding(.horizontal, 30)
            .zIndex(15)
        }
    }
}

struct MoveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoveDetailConfiguration.configuration(with: .mock, showView: .constant(true))
    }
}

