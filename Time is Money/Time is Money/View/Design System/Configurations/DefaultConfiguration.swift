//
//  DefaultConfiguration.swift
//  Time is Money
//
//  Created by Victor Melo on 11/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit
import Rswift

class DefaultConfiguration: ThemeConfigurationProtocol {
    let color: ColorStyle = DefaultColorStyle()
    let font: FontConfiguration = DefaultFontConfiguration()
    let enabledCornerRadius = true
    let cornerRadiusType = CornerRadiusType.three
}

class DefaultColorStyle: ColorStyle {
    let brandColor = R.color.defaultBrandColor()!
    let primaryColor = R.color.defaultPrimaryColor()!
    let secondaryColor = R.color.defaultSecondaryColor()!
    let complementaryColor = R.color.defaultComplementaryColor()!
    let enabledColor = R.color.defaultEnabledColor()!
    let disabledColor = R.color.defaultDisabledColor()!
}

class DefaultFontConfiguration: FontConfiguration {
    
    func light(size: FontSize) -> DSFont {
        getDSFont(size: size, weight: .light)
    }
    
    func regular(size: FontSize) -> DSFont {
        getDSFont(size: size, weight: .regular)
    }
    
    func semibold(size: FontSize) -> DSFont {
        getDSFont(size: size, weight: .semibold)
    }
    
    func bold(size: FontSize) -> DSFont {
        getDSFont(size: size, weight: .bold)
    }
    
    private func getDSFont(size: FontSize, weight: Font.Weight) -> DSFont {
        let font = Font.system(size: size.rawValue, weight: weight)
        let uiFont = UIFont.systemFont(ofSize: size.rawValue, weight: weight.uiFontWeight)
        return DSFont(swiftUIFont: font, uiKitFont: uiFont)
    }
}
