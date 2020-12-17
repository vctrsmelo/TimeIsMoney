//
//  View+Extensions.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Background
extension View {
    func withBackground(_ color: Color) -> some View {
        return ZStack {
            BackgroundView(color)
            self
        }
    }
}

// MARK: - Keyboard

enum KeyboardSensibleType {
    case padding
    case offset
    case paddingAndOffset
}

enum Keyboard {
    static var currentHeight: CGFloat = 0.0
}

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    func keyboardSensible(_ offsetValue: Binding<CGFloat>, type: KeyboardSensibleType, onAppearKeyboardCustom: (() -> Void)? = nil, onHideKeyboardCustom: (() -> Void)? = nil, backgroundColor: Color) -> some View {
        
        func adjustedType(_ type: KeyboardSensibleType) -> some View {
            switch type {
            case .padding:
                return ZStack {
                    BackgroundView(backgroundColor)
                    AnyView(self.padding(.bottom, offsetValue.wrappedValue))
                }
            case .offset:
                return ZStack {
                    BackgroundView(backgroundColor)
                        AnyView(self.offset(y: -offsetValue.wrappedValue))
                    }
            case .paddingAndOffset:
            return ZStack {
                    BackgroundView(backgroundColor)
                    AnyView(self.padding(.top, offsetValue.wrappedValue)
                           .offset(y: -offsetValue.wrappedValue))
                
                   }
            }
        }
        
        return
            adjustedType(type)
            .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                
                let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
                
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                
                offsetValue.wrappedValue = height - bottom
                
                Keyboard.currentHeight = height
                onAppearKeyboardCustom?()
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                offsetValue.wrappedValue = 0
                Keyboard.currentHeight = 0.0
                onHideKeyboardCustom?()
            }
        }
    }
    
}

// MARK: - Navigation Bar

extension View {
    
    func withoutNavigationBar() -> some View {
        return self
                .navigationBarTitle("")
                .navigationBarHidden(true)
    }
}

// MARK: - Adaptable Font

extension View {
    
    private func getSize(_ g: GeometryProxy, maxSize: CGFloat? = nil) -> CGFloat {
        
        let calculatedSize = (g.size.height > g.size.width) ? g.size.width * 0.4 : g.size.height * 0.4
        
        if let maxSize = maxSize {
            return calculatedSize > maxSize ? UIFontMetrics.default.scaledValue(for: maxSize) : calculatedSize
        } else {
            return calculatedSize
        }
    }
}

// MARK: - isHidden

extension View {
    func isHidden(_ bool: Bool) -> some View {
        modifier(HiddenModifier(isHidden: bool))
    }
}

private struct HiddenModifier: ViewModifier {

    fileprivate let isHidden: Bool

    fileprivate func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden().frame(height: 0)
            } else {
                content
            }
        }
    }
}
