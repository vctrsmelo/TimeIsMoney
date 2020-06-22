//
//  AvatarPickView.swift
//  Time is Money
//
//  Created by Victor Melo on 09/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI
import Rswift

struct OnboardingAvatarPickerView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    var body: some View {
        VStack {
            HStack {
                Text(R.string.localizable.selectYourAvatar())
                    .lineLimit(nil)
                    .font(config.font.bold(size: .title).swiftUIFont)
                    .foregroundColor(config.color.complementaryColor.swiftUIColor)
                    .frame(maxHeight: UIScreen.main.bounds.height/4)
            }
            VAvatarPickerView(buttonWidth: 100).environmentObject(appState)
        }.withBackground()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
}

struct AvatarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingAvatarPickerView()
    }
}
