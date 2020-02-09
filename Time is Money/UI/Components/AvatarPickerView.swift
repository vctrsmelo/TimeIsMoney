//
//  AvatarButtonsView.swift
//  Time is Money
//
//  Created by Victor Melo on 09/02/20.
//  Copyright © 2020 Victor S Melo. All rights reserved.
//

import SwiftUI

struct VAvatarPickerView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    let buttonWidth: CGFloat
    
    init(buttonWidth: CGFloat) {
        self.buttonWidth = buttonWidth
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    ForEach(AvatarFactory.allMale, id: \.id) {
                        AvatarButtonView(avatar: $0, isSelected: $0.id == self.appState.avatarId)
                    }
                }
                HStack {
                    ForEach(AvatarFactory.allFemale, id: \.id) {
                        AvatarButtonView(avatar: $0, isSelected: $0.id == self.appState.avatarId)
                    }
                }
            }
        }
    }
}

struct HAvatarPickerView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.interactors) var interactors: InteractorsContainer
    
    let buttonWidth: CGFloat
    
    init(buttonWidth: CGFloat) {
        self.buttonWidth = buttonWidth
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(AvatarFactory.all, id: \.id) {
                    AvatarButtonView(avatar: $0, isSelected: $0.id == self.appState.avatarId)
                }
            }
        }
    }
}

