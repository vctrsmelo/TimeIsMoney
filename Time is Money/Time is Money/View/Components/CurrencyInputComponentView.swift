//
//  CurrencyInputComponentView.swift
//  Time is Money
//
//  Created by Victor Melo on 06/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct CurrencyInputComponentView: View {
    
    @EnvironmentObject var appState: AppState
    @State private var isKeyboardVisible: Bool = false
    
    private var priceBinding: Binding<Decimal>
    private let currencyFieldWidth: CGFloat
    private let keyboardVisibleOffset: CGFloat
    private let cornerRadius: CGFloat
    
    init(isKeyboardVisible: Bool, priceBinding: Binding<Decimal>) {
        self.priceBinding = priceBinding
        self.currencyFieldWidth = UIScreen.main.bounds.width - (UIDevice.current.hasHomeButton ? 0 : 16)
        self.keyboardVisibleOffset = UIDevice.current.hasHomeButton ? 0 : -16
        self.cornerRadius = UIDevice.current.hasHomeButton ? 0 : 100
        self.isKeyboardVisible = isKeyboardVisible
    }
    
    var body: some View {
        VStack {
            Text("Type below the price")
                .font(appState.designSystem.font.light(size: .h4).asFont)
                .foregroundColor(appState.designSystem.color.complementary.asColor)
                .isHidden(isKeyboardVisible)

            CurrencyField(priceBinding, placeholder: "Income", designSystem: appState.designSystem)
                .background(Color(.sRGB, red: 94/255.0, green: 128/255.0, blue: 142/255.0, opacity: 1))
                .frame(width: currencyFieldWidth, height: 50, alignment: .center)
                .cornerRadius(cornerRadius)
        }
        .offset(x: 0, y: (isKeyboardVisible) ? keyboardVisibleOffset : 0)
    }
}

struct CurrencyInputComponentView_Previews: PreviewProvider {
    
    @State private static var price: Decimal = 100
    
    static var previews: some View {
        let priceBinding = Binding(
            get: { self.price },
            set: { self.price = $0 }
        )
        
        return CurrencyInputComponentView(isKeyboardVisible: false, priceBinding: priceBinding)
    }
}
