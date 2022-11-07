//
//  DefaultConfiguration.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit

class LightTheme: ThemeProtocol {
    let color: ColorTheme = LightColorTheme()
    let font: FontTheme = LightFontTheme()
    let enabledCornerRadius = true
    let cornerRadius = CornerRadiusTheme.three
}

class LightColorTheme: ColorTheme {
    let brandColor = R.color.defaultBrandColor()!
    let primaryColor = R.color.defaultPrimaryColor()!
    let secondaryColor = R.color.defaultSecondaryColor()!
    let complementaryColor = R.color.defaultComplementaryColor()!
    let enabledColor = R.color.defaultEnabledColor()!
    let disabledColor = R.color.defaultDisabledColor()!
}

class LightFontTheme: FontTheme {
    
    func light(size: FontSizeTheme) -> DSFont {
        getDSFont(size: size, weight: .light)
    }
    
    func regular(size: FontSizeTheme) -> DSFont {
        getDSFont(size: size, weight: .regular)
    }
    
    func semibold(size: FontSizeTheme) -> DSFont {
        getDSFont(size: size, weight: .semibold)
    }
    
    func bold(size: FontSizeTheme) -> DSFont {
        getDSFont(size: size, weight: .bold)
    }
    
    private func getDSFont(size: FontSizeTheme, weight: Font.Weight) -> DSFont {
        let font = Font.system(size: size.rawValue, weight: weight)
        let uiFont = UIFont.systemFont(ofSize: size.rawValue, weight: weight.uiFontWeight)
        return DSFont(swiftUIFont: font, uiKitFont: uiFont)
    }
}
