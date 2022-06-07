//
//  HomeHeaderView.swift
//  Time is Money
//
//  Created by Victor Melo on 10/06/21.
//  Copyright © 2021 Victor S Melo. All rights reserved.
//

import SwiftUI

struct HomeHeaderView: View {
    
    @Binding var user: User
    @Binding var isKeyboardVisible: Bool
    @Binding var isMonetaryValueZero: Bool
    @Binding var price: Money
    
    var body: some View {
        HStack {
            VStack {
                Text("It will take")
                    .multilineTextAlignment(.center)
                    .font(config.font.light(size: .body).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .animation(.none)
                    .isHidden(isMonetaryValueZero)
                Text(timeToPay())
                    .lineLimit(nil)
                    .font(config.font.bold(size: .title).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .multilineTextAlignment(.center)
                    .animation(.none)
                    .padding(.top, 10)
                
                WorkingTimeText(price: $price, user: $user)
                    .font(config.font.light(size: .body).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .padding(.top, 10)
                    .isHidden(isMonetaryValueZero)
                Group {
                    Text("to pay off these")
                        .multilineTextAlignment(.center)
                        .font(config.font.light(size: .body).swiftUIFont)
                        .foregroundColor(config.color.complementaryColor.swiftUIColor)
                        .animation(.none)
                        .isHidden(isMonetaryValueZero)
                    Text(formattedValue())
                        .frame(minWidth: 100, alignment: .center)
                        .font(config.font.bold(size: .subtitle).swiftUIFont)
                        .foregroundColor(config.color.complementaryColor.swiftUIColor)
                        .padding(.top, 10)
                        .isHidden(isMonetaryValueZero)
                    
                }
                .isHidden(isKeyboardVisible)
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
    }
    
    func timeToPay() -> String {
        guard case let .success(priceAsSeconds) = Calculator.getWorkTimeToPay(for: price, user: user) else
        { return "UNKNOWN"}
        return TimeTextTranslator.getWorkTimeDescriptionToPay(for: priceAsSeconds, user: user)
    }
    
    func formattedValue() -> String {
        price.decimalValue.currency
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    
    @State static var user: User = User()
    @State static var isKeyboardVisible = false
    @State static var isMonetaryValueZero = false
    @State static var price = Money(decimal: 10)
    
    static var previews: some View {
        HomeHeaderView(user: $user, isKeyboardVisible: $isKeyboardVisible, isMonetaryValueZero: $isMonetaryValueZero, price: $price)
    }
}
