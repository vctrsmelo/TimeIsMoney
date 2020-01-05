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
