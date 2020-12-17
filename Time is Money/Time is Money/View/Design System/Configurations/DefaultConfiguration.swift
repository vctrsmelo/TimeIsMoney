//
//  DefaultConfiguration.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

class DefaultConfiguration: ThemeConfigurationProtocol {
    let color: DSColorStyle = DefaultColorStyle()
    let font: DSFontConfiguration = DefaultFontConfiguration()
    let isCornerRadiusEnabled = true
    let cornerRadius = DSCornerRadius.three
}

class DefaultColorStyle: DSColorStyle {
    let brand = DSColor(named: "defaultBrandColor")
    let primary = DSColor(named: "defaultPrimaryColor")
    let secondary = DSColor(named: "defaultSecondaryColor")
    let complementary = DSColor(named: "defaultComplementaryColor")
    let enabled = DSColor(named: "defaultEnabledColor")
    let disabled = DSColor(named: "defaultDisabledColor")
}

struct DefaultFontConfiguration: DSFontConfiguration {
    
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
