//
//  WelcomeView.swift
//  Time is Money
//
//  Created by Victor Melo on 01/01/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            //image
            Image("MoneyClock_img")
                .resizable()
                .scaledToFit()
                .frame(minHeight: 150)
                .padding(.top, 20)
            //bem vindo
            Text("Welcome!")
                .font(Design.Font.Title.largeTitleFont)
                .foregroundColor(Design.Color.Text.title)
            
            //subtitle
            Text("Let's find out how much things really cost?")                    .lineLimit(nil)
                .adaptableFont(.subtitle, maxSize: 25)
                .foregroundColor(Design.Color.Text.title)
            Spacer()
            //description

            GeometryReader { g in
                Text("For this we will only need three information. Let's go? 😄")
                    .lineLimit(nil)
                    .frame(idealWidth: g.size.width-64, maxWidth: g.size.width, minHeight: 25, idealHeight: 50, alignment: .center)
                    .adaptableFont(.standardLight, maxSize: 20)
                    .foregroundColor(Design.Color.Text.standard)
            }
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
