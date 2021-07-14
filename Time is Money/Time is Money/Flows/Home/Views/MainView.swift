//
//  ContentView.swift
//  Time is Money
//
//  Created by Victor S Melo on 10/10/19.
//  Copyright © 2019 Victor S Melo. All rights reserved.
//

import SwiftUI
import UIKit
import Rswift

struct MainView: View {
    
    @Environment(\.interactors) var interactors: InteractorsContainer
    @EnvironmentObject var appState: AppState
    
    @State var offsetValue: CGFloat = 0.0
    @State var topTextPadding: CGFloat = 0.0
    @State var priceAsSeconds: TimeInterval = 100.0
    @State var isShowingEditView = false
    @State var isKeyboardVisible = false
    @State var isMonetaryValueZero: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HomeNavigationBarView(isKeyboardVisible: $isKeyboardVisible, isShowingEditView: $isShowingEditView)

            HomeHeaderView(user: $appState.user, isKeyboardVisible: $isKeyboardVisible, isMonetaryValueZero: $isMonetaryValueZero, priceAsSeconds: $priceAsSeconds)
            
            Spacer()
            
            WorkspaceImage(avatarId: $appState.avatarId, currentPrice: $appState.currentPrice, user: $appState.user)
            
            Spacer()
            
            InputSectionView(priceBinding: $appState.currentPrice, isKeyboardVisible: isKeyboardVisible)
            
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingEditView) {
            EditView().environmentObject(appState)
        }
        .onTapGesture(perform: hideKeyboard)
        .withBackground()
    }
}

struct ContentView_Previews: PreviewProvider {
    static let appState = AppState()
    static var previews: some View {
        ForEach(Self.supportedLocales, id:\.self) { locale in
            MainView()
                .environment(\.locale, locale)
                .environmentObject(appState)
        }
    }
}
