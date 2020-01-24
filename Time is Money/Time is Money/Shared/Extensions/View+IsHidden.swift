//
//  View+IsHidden.swift
//  Time is Money
//
//  Created by Victor Melo on 23/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

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
