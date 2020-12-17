//
//  ThemeConfigurationProtocol.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

 protocol DSFontConfiguration {
    func light(size: DSFontSize) -> DSFont
    func regular(size: DSFontSize) -> DSFont
    func bold(size: DSFontSize) -> DSFont
    func semibold(size: DSFontSize) -> DSFont
}

 enum DSFontSize: CGFloat {
    case h0 = 50.0
    case h1 = 24.0
    case h2 = 20.0
    case h3 = 16.0
    case h4 = 14.0
    case h5 = 12.0
    case h6 = 10.0
    
    static var heading = DSFontSize.h0
    static var title = DSFontSize.h1
    static var subtitle = DSFontSize.h2
    static var body = DSFontSize.h3
}

 enum DSSpacing: CGFloat {
    case pp = 4
    case p = 8
    case m = 16
    case g = 24
}

protocol DSColorStyle {
    var brand: DSColor { get }
    var primary: DSColor { get }
    var secondary: DSColor { get }
    var complementary: DSColor { get }
    var enabled: DSColor { get }
    var disabled: DSColor { get }
}

enum DSCornerRadius: Int {
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
    var color: DSColorStyle { get }
    var font: DSFontConfiguration { get }
    var isCornerRadiusEnabled: Bool { get }
    var cornerRadius: DSCornerRadius { get }
}

extension ThemeConfigurationProtocol {
    var cornerRadiusSize: CGFloat {
        isCornerRadiusEnabled ? cornerRadius.size : 0.0
    }
}

struct DSFont {
    let asFont: Font
    let asUIFont: UIFont
}

struct DSColor {
    let asColor: Color
    let asUIColor: UIColor
    
    init(named name: String) {
        asColor = Color(name)
        asUIColor = UIColor(named: name)!
    }
}
