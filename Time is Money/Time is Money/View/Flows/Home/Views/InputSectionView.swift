//
//  InputSectionView.swift
//  Time is Money
//
//  Created by Victor Melo on 10/06/21.
//  Copyright © 2021 Victor S Melo. All rights reserved.
//

import Foundation
import SwiftUI

// Create subviews private here
struct InputSectionView: View {
    
    @Binding var priceBinding: Currency
    
    var isKeyboardVisible: Bool
    
    var body: some View {
        let width = UIScreen.main.bounds.width - (UIDevice.current.hasHomeButton ? 0 : 16)
        let cornerRadius: CGFloat = UIDevice.current.hasHomeButton ? 0 : 100
        let keyboardVisibleOffset: CGFloat = UIDevice.current.hasHomeButton ? 0 : -16
        
        let income = R.string.localizable.income()
        
        return VStack {
            Text("Type below the price")
                .font(config.font.light(size: .h4).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .isHidden(isKeyboardVisible)
            
            CurrencyField($priceBinding, placeholder: income, textColor: .white)
                .background(config.color.complementaryColor.swiftUIColor)
                .frame(width: width, height: 50, alignment: .center)
                .cornerRadius(cornerRadius)
        }
        .offset(x: 0, y: (isKeyboardVisible) ? keyboardVisibleOffset : 0)
    }
}
