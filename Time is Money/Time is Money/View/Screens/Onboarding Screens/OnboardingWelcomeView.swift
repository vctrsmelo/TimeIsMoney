//
//  WelcomeView.swift
//  Time is Money
//
//  Created by Victor Melo on 01/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    
    var body: some View {
        VStack {

            Spacer()
            
            Image("MoneyClock_img")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 2/3 , minHeight: 150)
            
            Text("Welcome!")
                .font(DesignSystem.font.bold(size: .heading).asFont)
                .foregroundColor(DesignSystem.color.complementary.asColor)
                .padding(.top, 20)

            Spacer()
            
            Text("Let's find out how much things really cost?")
                .lineLimit(nil)
                .font(DesignSystem.font.regular(size: .subtitle).asFont)
                .foregroundColor(DesignSystem.color.complementary.asColor)
                .frame(idealWidth: UIScreen.main.bounds.width-64, maxWidth: UIScreen.main.bounds.width-16, minHeight: 25, idealHeight: 50, alignment: .center)
            
            Spacer()

            Text("For this we will need only a few information. Let's go? 😄")
                .lineLimit(nil)
                .font(DesignSystem.font.light(size: .subtitle).asFont)
                .foregroundColor(DesignSystem.color.complementary.asColor)
                .frame(idealWidth: UIScreen.main.bounds.width-64, maxWidth: UIScreen.main.bounds.width-16, minHeight: 25, idealHeight: 50, alignment: .center)
            Spacer()
        }
        .withBackground()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        return ForEach(Self.supportedLocales, id: \.identifier) { locale in
            OnboardingWelcomeView()
                .environment(\.locale, locale)
        }
    }
}
