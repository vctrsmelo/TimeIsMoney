//
//  Font+UIFont.swift
//  Time is Money
//
//  Created by Victor Melo on 12/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

extension Font.Weight {
    var uiFontWeight: UIFont.Weight {
        switch self {
        case .black: return .black
        case .bold: return .bold
        case .heavy: return .heavy
        case .light: return .light
        case .medium: return .medium
        case .regular: return .regular
        case .semibold: return .semibold
        case .thin: return .thin
        case .ultraLight: return .ultraLight
        default: return .regular
        }
    }
}

