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
    @State var isShowingAlert: Bool = false
    @State var isMonetaryValueZero: Bool = false
    
    var body: some View {
        //        let formattedValue = Formatter.currency.string(from: viewModel.appState.currentPrice) ?? "?"
        
        //        let priceBinding = Binding(
        //            get: { viewModel.appState.currentPrice.decimalValue },
        //            set: { viewModel.appState.currentPrice = NSDecimalNumber(decimal: $0) }
        //        )
        
        return VStack(alignment: .center, spacing: 0) {
            HomeNavigationBarView(isKeyboardVisible: $isKeyboardVisible,
                                  isShowingEditView: $isShowingEditView)
            HomeHeaderView(user: $appState.user, isKeyboardVisible: $isKeyboardVisible, isMonetaryValueZero: $isMonetaryValueZero, priceAsSeconds: $priceAsSeconds)
            
            Spacer()
            
            WorkspaceImage(avatarId: $appState.avatarId, currentPrice: $appState.currentPrice, user: $appState.user)
            
            Spacer()
            
            InputSectionView(priceBinding: $appState.currentPrice, isKeyboardVisible: isKeyboardVisible)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingEditView) {
            EditView().environmentObject(appState)
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .onAppear() {
            if self.appState.user.isOnboardingCompleted == false {
                self.appState.user.isOnboardingCompleted.toggle()
            }
            
            if self.appState.avatarId == "male2-deprecated" {
                self.isShowingAlert = true
                self.appState.avatarId = "male2"
            }
            
            self.interactors.mainInteractor.saveAppState()
        }.alert(isPresented: $isShowingAlert) {
            return Alert(title: Text(R.string.localizable.yayUpdate()), message: Text(R.string.localizable.nowYouCanSelectADifferentAvatarGoToSettingsScreenToSelectYours()), dismissButton: Alert.Button.default(Text("Ok")))
        }
        .gesture(TapGesture()
                    .onEnded {
                        self.hideKeyboard()
                    }
        )
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
