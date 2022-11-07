//
//  ThemeConfigurationProtocol.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

 protocol FontTheme {
    func light(size: FontSizeTheme) -> DSFont
    func regular(size: FontSizeTheme) -> DSFont
    func bold(size: FontSizeTheme) -> DSFont
    func semibold(size: FontSizeTheme) -> DSFont
}

 enum FontSizeTheme: CGFloat {
    case h0 = 50.0
    case h1 = 24.0
    case h2 = 20.0
    case h3 = 16.0
    case h4 = 14.0
    case h5 = 12.0
    case h6 = 10.0
    
    static var heading = FontSizeTheme.h0
    static var title = FontSizeTheme.h1
    static var subtitle = FontSizeTheme.h2
    static var body = FontSizeTheme.h3
}

 enum SpacingTheme: CGFloat {
    case pp = 4
    case p = 8
    case m = 16
    case g = 24
}

 protocol ColorTheme {
    var brandColor: UIColor { get }
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var complementaryColor: UIColor { get }
    var enabledColor: UIColor { get }
    var disabledColor: UIColor { get }

}

 enum CornerRadiusTheme: Int {
    case zero
    case one
    case two
    case three
    case four
    case five
    
    var size: CGFloat {
        CGFloat(self.rawValue)
    }
}

protocol ThemeProtocol {
    var color: ColorTheme { get }
    var font: FontTheme { get }
    var enabledCornerRadius: Bool { get }
    var cornerRadius: CornerRadiusTheme { get }
}

extension ThemeProtocol {
    var cornerRadiusSize: CGFloat {
        enabledCornerRadius ? cornerRadius.size : 0.0
    }
}
