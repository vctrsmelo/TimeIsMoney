//
//  View+Extensions.swift
//  Time is Money
//
//  Created by Victor Melo on 03/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func withBackground(_ color: Color = Design.Color.Background.standard) -> some View {
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


extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    func keyboardSensible(_ offsetValue: Binding<CGFloat>, type: KeyboardSensibleType, onAppearKeyboardCustom: (() -> Void)? = nil, onHideKeyboardCustom: (() -> Void)? = nil) -> some View {
        
        func adjustedType(_ type: KeyboardSensibleType) -> some View {
            switch type {
            case .padding:
                return AnyView(self.padding(.bottom, offsetValue.wrappedValue))
            case .offset:
                return AnyView(self.offset(y: -offsetValue.wrappedValue))
            case .paddingAndOffset:
                return AnyView(self.padding(.top, offsetValue.wrappedValue)
                           .offset(y: -offsetValue.wrappedValue))
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
                
                onAppearKeyboardCustom?()
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                offsetValue.wrappedValue = 0
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
