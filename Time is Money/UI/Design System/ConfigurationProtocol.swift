//
//  ThemeConfigurationProtocol.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

 protocol FontConfiguration {
    var regular: DSFont { get }
    var bold: DSFont { get }
    var semibold: DSFont { get }
}

 enum FontSize: CGFloat {
    case h1 = 24.0
    case h2 = 20.0
    case h3 = 16.0
    case h4 = 14.0
    case h5 = 12.0
    case h6 = 10.0
}

 enum Spacing: CGFloat {
    case pp = 4
    case p = 8
    case m = 16
    case g = 24
}

 protocol ColorStyle {
    var brandColor: UIColor { get }
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var tertiaryColor: UIColor { get }
    var darkColor: UIColor { get }
}

 enum CornerRadiusType: Int {
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



protocol ThemeConfigurationProtocol {
    var color: ColorStyle { get }
    var font: FontConfiguration { get }
    var enabledCornerRadius: Bool { get }
    var cornerRadiusType: CornerRadiusType { get }
}

extension ThemeConfigurationProtocol {
    var cornerRadiusSize: CGFloat {
        if enabledCornerRadius {
            return cornerRadiusType.size
        } else {
            return 0.0
        }
    }
}
