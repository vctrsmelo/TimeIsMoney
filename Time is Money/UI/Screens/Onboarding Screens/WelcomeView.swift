//
//  WelcomeView.swift
//  Time is Money
//
//  Created by Victor Melo on 01/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    let config = GlobalConfiguration.configuration
    
    var body: some View {
        VStack {
            //image
            Image("MoneyClock_img")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 2/3 , minHeight: 150)
                .padding(.top, 20)
            
            //bem vindo
            Text("Welcome!")
                .font(config.font.bold(size: .heading).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .padding(.bottom, 20)
            
            //subtitle
            Text("Let's find out how much things really cost?")
                .lineLimit(nil)
                .font(config.font.regular(size: .subtitle).swiftUIFont)
                .foregroundColor(config.color.complementaryColor.swiftUIColor)
                .frame(idealWidth: UIScreen.main.bounds.width-64, maxWidth: UIScreen.main.bounds.width-16, minHeight: 25, idealHeight: 50, alignment: .center)
            
            Spacer()
            //description

            Text(R.string.localizable.forThisWeWillNeedOnlyAFewInformationLetSGo😄())
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
            WelcomeView()
                .environment(\.locale, locale)
        }
    }
}
