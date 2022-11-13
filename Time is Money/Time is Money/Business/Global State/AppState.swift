//
//  AppState.swift
//  TimeIsMoneyCore
//
//  Created by Victor Melo on 07/02/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var user = User()
    @Published var avatarId = "male2-deprecated"
    @Published var workplace = ScenarioFactory.Workplace.office
    @Published var currentPrice = Currency(value: 0.0)
    private(set) var theme: UIUserInterfaceStyle = .light
    
    func getCurrentValue() -> Price {
        return Price(currency: currentPrice, user: user)
    }
    
    func setTheme(_ newTheme: UIUserInterfaceStyle) {
        print("did call setTheme with \(newTheme.rawValue)")
        self.theme = newTheme
        print("did call setTheme with \(theme.rawValue)")
        SceneDelegate.shared?.window?.overrideUserInterfaceStyle = newTheme
    }
}
