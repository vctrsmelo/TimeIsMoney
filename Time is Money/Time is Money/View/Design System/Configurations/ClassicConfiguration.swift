//
//  DefaultConfiguration.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

class ClassicConfiguration: ThemeConfigurationProtocol {
    static let id = "ClassicConfiguration"
    let color: DSColorStyle = ColorStyle()
    let font: DSFontConfiguration = FontConfiguration()
    let isCornerRadiusEnabled = true
    let cornerRadius = DSCornerRadius.three
}

private struct ColorStyle: DSColorStyle {
    let brand =             DSColor(named: "classicBrandColor")
    let primary =           DSColor(named: "classicPrimaryColor")
    let secondary =         DSColor(named: "classicSecondaryColor")
    let complementary =     DSColor(named: "classicComplementaryColor")
    let enabled =           DSColor(named: "classicEnabledColor")
    let disabled =          DSColor(named: "classicDisabledColor")
}

private struct FontConfiguration: DSFontConfiguration {
    
    func light(size: DSFontSize) -> DSFont {
        getDSFont(size: size, weight: .light)
    }
    
    func regular(size: DSFontSize) -> DSFont {
        getDSFont(size: size, weight: .regular)
    }
    
    func semibold(size: DSFontSize) -> DSFont {
        getDSFont(size: size, weight: .semibold)
    }
    
    func bold(size: DSFontSize) -> DSFont {
        getDSFont(size: size, weight: .bold)
    }
    
    private func getDSFont(size: DSFontSize, weight: Font.Weight) -> DSFont {
        let font = Font.system(size: size.rawValue, weight: weight)
        let uiFont = UIFont.systemFont(ofSize: size.rawValue, weight: weight.uiFontWeight)
        return DSFont(asFont: font, asUIFont: uiFont)
    }
}
