//
//  WelcomeView.swift
//  Time is Money
//
//  Created by Victor Melo on 01/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    
    let config = GlobalConfiguration.configuration
    
    var body: some View {
        VStack {

            Spacer()
            
            Image("MoneyClock_img")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 2/3 , minHeight: 150)
            
            
            Text("Welcome!")
                .font(config.font.bold(size: .heading).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .padding(.top, 20)

            Spacer()
            
            Text("Let's find out how much things really cost?")
                .lineLimit(nil)
                .font(config.font.regular(size: .subtitle).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .frame(idealWidth: UIScreen.main.bounds.width-64, maxWidth: UIScreen.main.bounds.width-16, minHeight: 25, idealHeight: 50, alignment: .center)
            
            Spacer()

            Text("For this we will need only a few information. Let's go? 😄")
                .lineLimit(nil)
                .font(config.font.light(size: .subtitle).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
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
