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
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Design.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                //image
                Image("MoneyClock")
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 20, leading: 16, bottom: 62, trailing: 16))
                //bem vindo
                Text("Welcome!")
                    .font(Design.textTitleFont)
                    .foregroundColor(Design.textTitleColor)
                    .padding(.bottom, 15)
                
                Group {
                    //subtitle
                    Text("Let's find out how much things really cost?")
                        .font(Design.textSubtitleFont)
                        .foregroundColor(Design.textTitleColor)
                        .padding(.bottom, 43)
                    
                    //description
                    Text("For this we will only need two information. Let's go? 😄")
                        .font(Design.textDefaultFont)
                        .foregroundColor(Design.textDefaultColor)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width-64)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
