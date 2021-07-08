//
//  AlertView.swift
//  Pokedex
//
//  Created by Luis Pineda on 7/07/21.
//

import SwiftUI

enum AlertType {
    case success
    case error
    case info
    case confirm
    
    var tintColor: Color {
        switch self {
        case .success:
            return Color.pFourth
        case .error:
            return Color.pThird
        case .info:
            return Color.blue
        case .confirm:
            return Color.blue
        }
    }
    var icon: String {
        switch self {
        case .success:
            return "checkmark"
        case .error:
            return "xmark"
        case .info:
            return "hand.thumbsup.fill"
        case .confirm:
            return "questionmark"
        }
        
    }
}

struct AlertView: ViewModifier {
    let padding: CGFloat = 20
    
    var alert: AlertModel
    @Binding var showAlert: Bool
    @State var isOpacity: Bool = false
    @State var animation = false
    var onConfirm: ((Int) -> Void)? = nil
    var onClose: ((Int) -> Void)? = nil
    
    func body(content: Content) -> some View {
        ZStack {
            if self.$isOpacity.wrappedValue {
                Color.pBackground.colorInvert().opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(10)
                    .animation(.default)
            }
            content.disabled(showAlert)
            if showAlert {
                VStack(spacing: .zero) {
                    Image(systemName: alert.type.icon)
                        .textFontSize(size:  40,
                                      color: Color.pSecondaryText,
                                      decoration: .bold)
                        .scaleEffect(animation ? 0.8 : 0.2)
                        .rotationEffect(animation ? .degrees(360) : .degrees(0))
                        .animation(Animation.easeIn(duration: 0.5))
                        .frame(width: 80, height: 80)
                        .background(alert.type.tintColor)
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
                        Text(alert.title)
                            .multilineTextAlignment(.center)
                            .titleFont(decoration: .bold)
                        Text(alert.text)
                            .textFont()
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, padding)
                        HStack(spacing: padding) {
                            if alert.type == AlertType.confirm {
                                ButtonSecondary(text: alert.textClose) {
                                    self.close()
                                    self.onClose?(self.alert.id)
                                }
                                ButtonPrimary(text: alert.textConfirm) {
                                    self.close()
                                    self.onConfirm?(self.alert.id)
                                }
                            } else {
                                ButtonPrimary(text: alert.textClose, color: alert.type.tintColor) {
                                    self.close()
                                    self.onClose?(self.alert.id)
                                }
                            }
                        }
                    }.padding([.horizontal, .bottom], 25)
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
    func close() {
        self.showAlert = false
        self.animation = false
//        withAnimation {
            self.isOpacity = false
//        }
    }
}

extension View {
    func alertView(alert: AlertModel,
                   showAlert: Binding<Bool>,
                   onConfirm: ((Int) -> Void)? = nil,
                   onClose: ((Int) -> Void)? = nil) -> some View {
        self.modifier(AlertView(alert: alert,
                                showAlert: showAlert,
                                onConfirm: onConfirm,
                                onClose: onClose))
    }
    
    func alertView(alert: Binding<AlertModel?>,
                   onConfirm: ((Int) -> Void)? = nil,
                   onClose: ((Int) -> Void)? = nil) -> some View {
        guard let alertModel = alert.wrappedValue else { return self.eraseToAnyView() }
        return self.modifier(
            AlertView(alert: alertModel,
                      showAlert: Binding(
                        get: { alert.wrappedValue != nil },
                        set: { show in if !show { alert.wrappedValue = nil } }
                      ),
                      onConfirm: onConfirm,
                      onClose: onClose)
        ).eraseToAnyView()
    }
}

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}

