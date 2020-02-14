//
//  AvatarButtonView.swift
//  Time is Money
//
//  Created by Victor Melo on 09/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct AvatarButtonView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    private let buttonWidth: CGFloat
    private let buttonPadding: EdgeInsets
    
    private let isSelected: Bool
    private let avatar: Avatar

    init(avatar: Avatar, isSelected: Bool, buttonWidth: CGFloat = 100, buttonPadding: EdgeInsets = EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)) {
        self.avatar = avatar
        self.isSelected = isSelected
        self.buttonWidth = buttonWidth
        self.buttonPadding = buttonPadding
    }
    
    var body: some View {
        Button(action: {
            self.appState.avatarId = self.avatar.id
        }) {
            avatar.happy
                .avatarViewModifiers(avatarWidth: buttonWidth, buttonPadding: buttonPadding, isSelected: isSelected)
                
        }
    }
}

struct AvatarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarButtonView(avatar: AvatarFactory.male2(), isSelected: true)
    }
}

private extension Image {
    func avatarViewModifiers(avatarWidth: CGFloat, buttonPadding: EdgeInsets, isSelected: Bool) -> some View {
        self
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(width: avatarWidth, alignment: .center)
            .padding(buttonPadding)
            .scaleEffect(isSelected ? 0.90 : 1)
            .animation(.easeInOut)
            .background(isSelected ? GlobalConfiguration.configuration.color.enabledColor.swiftUIColor : GlobalConfiguration.configuration.color.disabledColor.swiftUIColor)
            .cornerRadius(32)

    }
}
