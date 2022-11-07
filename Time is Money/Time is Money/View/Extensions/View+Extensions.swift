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
    func withBackground(_ color: Color = GlobalConfiguration.theme.color.primaryColor.swiftUIColor) -> some View {
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
