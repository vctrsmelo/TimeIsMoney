//
//  AvatarPickView.swift
//  Time is Money
//
//  Created by Victor Melo on 09/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct OnboardingAvatarPickerView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    var body: some View {
        VStack {
            HStack {
                Text("Select your Avatar")
                    .lineLimit(nil)
                    .font(appState.designSystem.font.bold(size: .title).asFont)
                    .foregroundColor(appState.designSystem.color.complementary.asColor)
                    .frame(maxHeight: UIScreen.main.bounds.height/4)
            }
            VAvatarPickerView(buttonWidth: 100).environmentObject(appState)
        }
        .withBackground(appState.designSystem.color.primary.asColor)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
}

struct AvatarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingAvatarPickerView()
    }
}
