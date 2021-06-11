////
////  DarkModeConfiguration.swift
////  Time is Money
////
////  Created by Victor Melo on 12/02/20.
////  Copyright © 2020 Victor S Melo. All rights reserved.
////
//
//import SwiftUI
//import UIKit
//
//class DarkModeConfiguration: ThemeConfigurationProtocol {
//    let color: ColorStyle = DarkModeColorStyle()
//    let font: FontConfiguration = DarkModeFontConfiguration()
//    let enabledCornerRadius = true
//    let cornerRadiusType = CornerRadiusType.three
//}
//
//class DarkModeColorStyle: ColorStyle {
//    let brandColor = #colorLiteral(red: 0.2784313725, green: 0.3725490196, blue: 0.3137254902, alpha: 1)
//    let primaryColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//    let secondaryColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    let complementaryColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    let enabledColor = #colorLiteral(red: 0.862745098, green: 0.4784313725, blue: 0.2588235294, alpha: 1)
//    let disabledColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
//}
//
//class DarkModeFontConfiguration: FontConfiguration {
//    
//    func light(size: FontSize) -> DSFont {
//        getDSFont(size: size, weight: .light)
//    }
//    
//    func regular(size: FontSize) -> DSFont {
//        getDSFont(size: size, weight: .regular)
//    }
//    
//    func semibold(size: FontSize) -> DSFont {
//        getDSFont(size: size, weight: .semibold)
//    }
//    
//    func bold(size: FontSize) -> DSFont {
//        getDSFont(size: size, weight: .bold)
//    }
//    
//    private func getDSFont(size: FontSize, weight: Font.Weight) -> DSFont {
//        let font = Font.system(size: size.rawValue, weight: weight)
//        let uiFont = UIFont.systemFont(ofSize: size.rawValue, weight: weight.uiFontWeight)
//        return DSFont(swiftUIFont: font, uiKitFont: uiFont)
//    }
//}
