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
        GeometryReader { geometry in
            VStack {
                Spacer()
                    .frame(height: 100)
                
                Image("MoneyClock_img")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 2/4.5 , minHeight: 150)
                
                Text("Welcome!")
                    .font(DesignSystem.font.bold(size: .heading).asFont)
                    .foregroundColor(DesignSystem.color.complementary.asColor)
                    .padding(.top, DSSpacing.l)
                
                    Spacer()
                        .frame(minHeight: DSSpacing.m, maxHeight: DSSpacing.l)
                
                Text("Let's find out how much things really cost?")
                    .lineLimit(nil)
                    .font(DesignSystem.font.bold(size: .subtitle).asFont)
                    .foregroundColor(DesignSystem.color.complementary.asColor)
                    .frame(width: geometry.size.width - DSSpacing.xxl,
                           alignment: .leading)
                
                Spacer()

                Text("For this we will need only a few information. Let's go? 😄")
                    .lineLimit(nil)
                    .font(DesignSystem.font.regular(size: .subtitle).asFont)
                    .foregroundColor(DesignSystem.color.complementary.asColor)
                    .frame(width: geometry.size.width - DSSpacing.xxl,
                           alignment: .leading)
                
                
                Spacer()
                    .frame(height: DSSpacing.xxl)
                
            }
            .withBackground()
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
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
