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
    let color: ColorStyle = DefaultColorStyle()
    let font: FontConfiguration = DefaultFontConfiguration()
    let enabledCornerRadius = true
    let cornerRadiusType = CornerRadiusType.three
}

class DefaultColorStyle: ColorStyle {
    let brandColor = #colorLiteral(red: 0.2784313725, green: 0.3725490196, blue: 0.3137254902, alpha: 1) //475F50
    let primaryColor = #colorLiteral(red: 1, green: 0.9960784314, blue: 0.9450980392, alpha: 1) //FFFEF1
    let secondaryColor = #colorLiteral(red: 1, green: 0.9960784314, blue: 0.9450980392, alpha: 1) //B1B094
    let complementaryColor = #colorLiteral(red: 0.2823529412, green: 0.3647058824, blue: 0.4117647059, alpha: 1) //485D69
    let enabledColor = #colorLiteral(red: 0.862745098, green: 0.4784313725, blue: 0.2588235294, alpha: 1) //DC7A42
    let disabledColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1) //787878
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
